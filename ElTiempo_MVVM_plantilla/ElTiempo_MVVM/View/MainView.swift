//
//  ViewController.swift
//  ElTiempo_MVVM
//
//

import UIKit
import Combine

class MainView: UIViewController {
    let viewModel = TiempoViewModel()
    private var bindingRespuesta : AnyCancellable!
    private var bindingIcono : AnyCancellable!

    @IBOutlet weak var estadoLabel: UILabel!
    @IBOutlet weak var estadoImage: UIImageView!
    @IBOutlet weak var campoTexto: UITextField!
    
    
    @IBAction func botonPulsado(_ sender: Any) {
        Task {
            await viewModel.consultarTiempoActual(localidad:campoTexto.text ?? "")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bindingRespuesta = viewModel.$estado.assign(to: \.text!, on: estadoLabel)
        
        bindingIcono = viewModel.$iconoUrl
            .filter{ !$0.isEmpty }
            .map{ urlString -> UIImage? in
                guard let url = URL(string: urlString) else { return nil }
                guard let datos = try? Data(contentsOf: url) else { return nil }
                return UIImage(data: datos)
            }
            .assign(to: \.image, on: estadoImage)
    }


}

