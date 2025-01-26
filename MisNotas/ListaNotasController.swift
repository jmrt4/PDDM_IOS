import UIKit
import CoreData

class ListaNotasController: UITableViewController, UISearchResultsUpdating {
    var listaNotas: [Nota]!
    let searchController = UISearchController(searchResultsController: nil)
    let throttler = Throttler(minimumDelay: 0.5)

    override func viewDidLoad() {
        super.viewDidLoad()

        //iOS intentará pintar la tabla, hay que inicializarla aunque sea vacía
        self.listaNotas = []
        //ListaNotasController recibirá lo que se está escribiendo en la barra de búsqueda
        searchController.searchResultsUpdater = self
        //Configuramos el search controller
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Buscar texto"
        //Lo añadimos a la tabla
        searchController.searchBar.sizeToFit()
        self.tableView.tableHeaderView = searchController.searchBar

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        throttler.throttle {
            let texto = searchController.searchBar.text!
            print("Buscando \(texto)")
            
            if texto != "" {
                guard let miDelegate = UIApplication.shared.delegate as? AppDelegate else {
                    return
                }
                
                let miContexto = miDelegate.persistentContainer.viewContext
                let request = NSFetchRequest<Nota>(entityName: "Nota")
                let pred = NSPredicate(format: "texto CONTAINS[c] %@", argumentArray: [texto])
                let fechaSort = NSSortDescriptor(key: "fecha", ascending: false)
                request.predicate = pred
                request.sortDescriptors = [fechaSort]
                let resultados = try! miContexto.fetch(request)
                self.listaNotas = resultados
                self.tableView.reloadData()
            } else {
                self.cargarTodasLasNotas()
            }
        }
    }
    
    func cargarTodasLasNotas() {
        guard let miDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let miContexto = miDelegate.persistentContainer.viewContext
        let request = Nota.fetchRequest()
        let fechaSort = NSSortDescriptor(key: "fecha", ascending: false)
        request.sortDescriptors = [fechaSort]
        let notas = try! miContexto.fetch(request)
        
        self.listaNotas = notas
        self.tableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        cargarTodasLasNotas()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.listaNotas.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MiCelda", for: indexPath)

        cell.textLabel?.text = self.listaNotas[indexPath.row].texto
        cell.detailTextLabel?.text = self.listaNotas[indexPath.row].libreta?.nombre

        return cell
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
