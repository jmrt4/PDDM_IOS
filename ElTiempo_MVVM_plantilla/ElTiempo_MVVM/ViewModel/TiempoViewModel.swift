//
//  TiempoViewModel.swift
//  ElTiempo_MVVM
//
//  Created by Otto Colomina Pardo on 20/1/22.
//

import Foundation
import Combine

class TiempoViewModel {
    let modelo = TiempoModelo()
    
    @Published
    var estado: String = ""
    
    @Published
    var iconoUrl: String = ""
    
    func consultarTiempoActual(localidad : String) async {
        let result = try? await modelo.consultarTiempoActual(localidad: localidad)
        if let result = result {
            await MainActor.run {
                self.estado = result.estado
                self.iconoUrl = result.urlIcono
            }
        }
    }
    
}
