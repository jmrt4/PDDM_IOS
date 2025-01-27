//
//  Tiempo.swift
//  ElTiempo_MVVM
//
//  Created by Otto Colomina Pardo on 20/1/22.
//
import Foundation

class TiempoModelo {
    let OW_URL_BASE = "https://api.openweathermap.org/data/2.5/weather?lang=es&units=metric&appid=1adb13e22f23c3de1ca37f3be90763a9&q="
    let OW_URL_BASE_ICON = "https://openweathermap.org/img/w/"
    
    func consultarTiempoActual(localidad:String) async throws -> (estado: String, urlIcono: String){
        var estado = ""
        var urlIcono = ""
        
        let urlString = OW_URL_BASE+localidad
        let url = URL(string:urlString)
        let (datos, _) = try await URLSession.shared.data(from: url!)
        
        let tiempo = try JSONDecoder().decode(CurrentLocalWeather.self, from: datos)
        estado = tiempo.weather[0].description
        let icono = tiempo.weather[0].icon
        urlIcono = self.OW_URL_BASE_ICON+icono+".png"
        
        return (estado:estado, urlIcono: urlIcono)
    }
    
}
