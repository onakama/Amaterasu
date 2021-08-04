//
//  WeatherModel.swift
//  Amaterasu
//
//  Created by nekuro on 2021/07/27.
//

import Foundation
import YumemiWeather
import SwiftUI

protocol WeatherModel{
    func fetch(request: String, completion: @escaping(Result<Response, WeatherError>) -> Void)
}


class WeatherModelImpl: WeatherModel{
    func fetch(request: String, completion: @escaping(Result<Response, WeatherError>) -> Void){
            if let responseAPI: String = try? YumemiWeather.syncFetchWeather(request){
                if let response: Response = try? changeIcon(jsonDecode(jsonData: responseAPI)){
                    completion(.success(response))
                }else{
                    completion(.failure(WeatherError.jsonDecodeError))
                }
            }else{
                completion(.failure(WeatherError.yumemiWeatherError))
            }
    }
    
    private func changeIcon(_ weather: Weather) -> Response{
        var response: Response = Response(icon: "", iconColor: Color.white, maxTemp: weather.max_temp, minTemp: weather.min_temp)
        switch weather.weather {
        case weatherType.sunny.rawValue:
            response.icon = "sunnyImage"
            response.iconColor = Color.red
        case weatherType.cloudy.rawValue:
            response.icon = "cloudyImage"
            response.iconColor = Color.gray
        case weatherType.rainy.rawValue:
            response.icon = "rainyImage"
            response.iconColor = Color.blue
        default:
            response.icon = "unknown"
            response.iconColor = Color.white
        }
        return response
    }
    
    func jsonDecode(jsonData: String)throws -> Weather{
        guard let jsonData = jsonData.data(using: .utf8) else {
            throw WeatherError.jsonDecodeError
        }
        guard let weather: Weather = try? JSONDecoder().decode(Weather.self, from: jsonData) else {
            throw WeatherError.jsonDecodeError
        }
        return weather
    }
    
    enum weatherType: String{
        case sunny = "sunny"
        case cloudy = "cloudy"
        case rainy = "rainy"
    }
    
    struct Weather: Decodable {
        var max_temp: Int
        var date: String
        var min_temp: Int
        var weather: String
    }

    
}
