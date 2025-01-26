import Foundation

extension Nota {
    //Devuelve una subcadena solo con la primera letra del texto
    @objc var inicial: String? {
        if let textoNoNil = self.contenido {
            return String(textoNoNil.first!)
        }
        else {
            return nil
        }
    }
}
