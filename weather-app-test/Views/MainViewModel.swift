//
//  MainViewModel.swift
//  weather-app-test
//
//  Created by  spy on 17.03.2023.
//

import Foundation
import SwiftUI

extension ContentView {

    class MainViewModel: ObservableObject {
        @Published var currentWeatherDataSource: ForecastResponse?
        @Published var viewModelStatus = MainViewModelStatus.loading;
       
        func callForecastAPI() {
            viewModelStatus = .loading
            let currentCity = UserDefaults.standard.object(forKey: "currentCity") as? String
            WeatherManager.getWeatherForecast(city: currentCity ?? "London")
            
            WeatherManager.didFetchForecastData = {  [weak self] in
                DispatchQueue.main.async{
                    self?.currentWeatherDataSource = WeatherManager.forecastData
                    self?.viewModelStatus = .loaded
                }
                
            }
        }
    }
    
    enum MainViewModelStatus {
        case loading
        case loaded
        
    }
 }
