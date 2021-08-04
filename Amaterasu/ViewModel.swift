//
//  ViewController.swift
//  Amaterasu
//
//  Created by nekuro on 2021/07/27.
//

import Foundation
import SwiftUI

class ViewModel: ObservableObject{
    @Published var weatherIcon: String
    @Published var weatherColor: Color
    @Published var maxTemp: String
    @Published var minTemp: String
    @Published var isError: Bool = false
    @Published var isLoading: Bool = false
    private (set) var errorMessage: String = ""

    let requestData = """
        {
        "date":"020-04-01T12:00:00+09:00","area":"tokyo"
        }
        """
    
    init() {
        self.weatherIcon = "unknown"
        self.weatherColor = Color.white
        self.maxTemp = "--"
        self.minTemp = "--"
    }
    
    func changeWeather(){
        self.isLoading = true
        let weatherModel: WeatherModel = WeatherModelImpl()
        weatherModel.fetch(request: requestData){ result in
            DispatchQueue.main.async {
                self.setWeather(result: result)
                self.isLoading = false
            }
        }
    }
    
    func setWeather(result: Result<Response, WeatherError>){
        switch result{
        case .success(let response):
            self.weatherIcon = response.icon
            self.weatherColor = response.iconColor
            self.maxTemp = String(response.maxTemp)
            self.minTemp = String(response.minTemp)
        case .failure(let error):
            switch error {
            case .yumemiWeatherError:
                self.errorMessage = "YumemiWeatherError"
                self.isError = true
                print(errorMessage)
            case .jsonDecodeError:
                self.errorMessage = "jsonDecodeError"
                self.isError = true
                print(errorMessage)
            }
        }
    }
}
