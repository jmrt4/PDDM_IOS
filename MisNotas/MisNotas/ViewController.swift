import UIKit
import CoreData

class ViewController: UIViewController {
    let miGestorPicker = GestorPicker()

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pickerView.delegate = self.miGestorPicker
        self.pickerView.dataSource = self.miGestorPicker
        
        self.miGestorPicker.cargarLista()
    }

    @IBAction func crear(_ sender: Any) {
        self.textView.text = ""
        self.label.text = ""
    }
    
    @IBAction func guardar(_ sender: Any) {
        guard let miDelegate = UIApplication.shared.delegate as? AppDelegate else {
            return
        }
        
        let miContexto = miDelegate.persistentContainer.viewContext
        
        let nuevaNota = Nota(context:miContexto)
        nuevaNota.fecha = Date()
        nuevaNota.texto = self.textView.text
        
        let numLibreta = self.pickerView.selectedRow(inComponent: 0)
        nuevaNota.libreta = self.miGestorPicker.libretas[numLibreta]
        
        do {
            try miContexto.save()
            
            self.label.text = DateFormatter.localizedString(from: nuevaNota.fecha!, dateStyle: .short, timeStyle: .medium)
            
            let alerta = UIAlertController(title: "Nota guardada", message: "La nota se guardado correctamente", preferredStyle: .alert)
            alerta.addAction(UIAlertAction(title: "Aceptar", style: .default))
            present(alerta, animated: true)
        } catch {
            print("Error al guardar el contexto: \(error)")
        }
    }
    
    @IBAction func nuevaLibreta(_ sender: Any) {
        let alert = UIAlertController(title: "Nueva libreta",
                                          message: "Escribe el nombre para la nueva libreta",
                                          preferredStyle: .alert)
            let crear = UIAlertAction(title: "Crear", style: .default) {
                action in
                let nombre = alert.textFields![0].text!
                
                guard let miDelegate = UIApplication.shared.delegate as? AppDelegate else {
                    return
                }
                
                let miContexto = miDelegate.persistentContainer.viewContext
                
                let nuevaLibreta = Libreta(context:miContexto)
                nuevaLibreta.nombre = nombre
                
                do {
                    try miContexto.save()
                    self.miGestorPicker.libretas.append(nuevaLibreta)
                    self.pickerView.reloadAllComponents()
                } catch {
                    print("Error al guardar el contexto: \(error)")
                }
                
            }
            let cancelar = UIAlertAction(title: "Cancelar", style: .cancel) {
                action in
            }
            alert.addAction(crear)
            alert.addAction(cancelar)
            alert.addTextField() { $0.placeholder = "Nombre"}
            self.present(alert, animated: true)

    }
}

