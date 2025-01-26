import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let file = "prueba.txt"  //nombre del archivo
        let text = "hola iOS"    //texto que escribiremos en él

        //obtenemos la URL del directorio Documents
        if let dir = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first {
            //le añadimos detrás el "/prueba.txt"
            let fileURL = dir.appendingPathComponent(file)
            //guardamos el String en el archivo
            try! text.write(to: fileURL, atomically: false, encoding: .utf8)
        }
    }


}

