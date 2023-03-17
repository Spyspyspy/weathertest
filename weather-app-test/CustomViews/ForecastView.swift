//
//  ForecastView.swift
//  weather-app-test
//
// Created by spy on 16/03/23.
//

import SwiftUI

struct DailyWeatherView: View {
    var forecastDataSource: Forecastday
    
    @ObservedObject var imageLoader:ImageLoader
    @State var image:UIImage = UIImage()
    
    init(withForecaset forecastDataSource:Forecastday) {
        self.forecastDataSource = forecastDataSource
        imageLoader = ImageLoader(urlString:"https:" + forecastDataSource.day.condition.icon)
    }
    
    var body: some View {
        VStack {
            Text(((forecastDataSource.date.stringToDate().dayOfWeek()) ?? "DAY").prefix(3))
                .font(.system(size: 20, weight: .light))
                .foregroundColor(Color.black)
            
            AsyncImageTemplate(url: URL(string: "https:" + forecastDataSource.day.condition.icon))
                .frame(width: 50, height: 50)
            
            Text("min: \(String(Int(forecastDataSource.day.mintempC )))°")
                .font(.system(size: 20, weight: .regular))
                .foregroundColor(Color.black)
            Text("max: \(String(Int(forecastDataSource.day.maxtempC )))°")
                .font(.system(size: 20, weight: .regular))
                .foregroundColor(Color.black)
        }
        .padding(.all, 10)
        .padding(.leading, 15)
        .padding(.trailing, 15)
        .background(RoundedRectangle(cornerRadius: 20).fill(Color(#colorLiteral(red: 0.1277317197, green: 0.8947259689, blue: 1, alpha: 1))))
    }
}

