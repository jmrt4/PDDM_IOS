//
//  ViewController.swift
//  PersistenciaBasica
//
//  Created by Master Moviles on 26/1/25.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet var textView: UITextView!
    @IBOutlet var label: UILabel!
    var fechaEdicion: Date?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let preferencias = UserDefaults()
        
        self.fechaEdicion = preferencias.object(forKey: "fecha") as? Date
        self.textView.text = preferencias.string(forKey: "texto")
        
        if self.fechaEdicion != nil {
            pintarFecha()
        }
    }

    func pintarFecha() {
        self.label.text = DateFormatter.localizedString(from: self.fechaEdicion!, dateStyle: .short, timeStyle: .medium)
    }
    
    @IBAction func guardar(_ sender: Any) {
        self.fechaEdicion = Date()
        
        pintarFecha()
        
        let prefs = UserDefaults()
        prefs.set(self.fechaEdicion, forKey: "fecha")
        prefs.set(self.textView.text, forKey: "texto")
    }

}

