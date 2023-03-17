//
//  WeatherManager.swift
//  weather-app-test
//
//  Created by spy on 16/03/23.
//

import Foundation

class WeatherManager {
    
    static var didFetchData: (() -> Void)?
    static var didFetchForecastData: (() -> Void)?
    static var weatherData: Current?
    static var forecastData: ForecastResponse?
    
    static func getWeatherForecast(city: String) {
        var urlComponents = URLComponents(string: "https://api.weatherapi.com/v1/forecast.json?")
        urlComponents?.queryItems = [
            URLQueryItem(name: "key", value: "522db6a157a748e2996212343221502"),
            URLQueryItem(name: "q", value: city),
            URLQueryItem(name: "days", value: "7"),
            URLQueryItem(name: "aqi", value: "no"),
            URLQueryItem(name: "alerts", value: "no")
        ]
        let url = urlComponents?.url
        var request = URLRequest(url: url!)
        request.httpMethod = "GET"
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                if let weather = try? JSONDecoder().decode(ForecastResponse.self,from: data) {
                    forecastData = weather
                     didFetchForecastData?()
                } else {
                    print("Invalid response")
                }
            } else if error != nil {
                print("HTTP request Failed ")
            }
        }
        task.resume()
    }
}
