import UIKit

class ViewController: UIViewController {

    struct Alumno : Codable {
        var nombre : String
        var notas : [Float]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let a1 = Alumno(nombre: "Pepe", notas: [5, 8.5, 10])
        let a2 = Alumno(nombre: "Eva", notas: [10, 9])
        let alumnos = [a1,a2]
        
        var urlDocs = FileManager.default.urls(for:.documentDirectory,
                                               in:.userDomainMask)[0]
        let urlPlist = urlDocs.appendingPathComponent("alumnos.plist")
        let encoder = PropertyListEncoder()
        encoder.outputFormat = .xml
        
        do {
            let data = try encoder.encode(alumnos)
            try data.write(to: urlPlist)
        } catch {
            
        }
    }
}

