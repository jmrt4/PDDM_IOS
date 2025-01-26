import UIKit
import CoreData

class ViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    @IBOutlet weak var label: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
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
}

