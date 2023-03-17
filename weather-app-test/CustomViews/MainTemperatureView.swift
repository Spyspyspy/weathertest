//
//  MainTemperatureView.swift
//  weather-app-test
//
//  Created by  spy on 17.03.2023.
//

import SwiftUI

struct MainTemperatureView: View {
    @Binding var isNight: Bool
    var currentWeather: Current?
    var weatherImage: String
    var date: Float
    var body: some View {
        VStack(spacing: 5) {
            AsyncImageTemplate(url:URL(string: "https:" + (currentWeather?.condition.icon ?? "") )) {
                image in
                image.renderingMode(.original)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 180, height: 180)
            } placeholder: {
                Color.green
            }
            .padding(.bottom, 50)
            .foregroundColor(isNight ? Color.white : Color.black)
            
            Text(currentWeather?.condition.text ?? "status")
                .font(.system(size: 20, weight: .light))
                .foregroundColor(isNight ? Color.white : Color.black)
            
            Text("\(Int(date))°c")
                .font(.system(size: 70, weight: .medium))
                .foregroundColor(isNight ? Color.white : Color.black)
            
            
            HStack(spacing: 5){
                Image(systemName: ImageNames.wind.rawValue)
                    .foregroundColor(isNight ? Color.white : Color.black)
                
                Text(String(currentWeather?.windKph ?? 0) + " kph")
                    .foregroundColor(isNight ? Color.white : Color.black)
                
                Image(systemName: ImageNames.drop.rawValue)
                    .foregroundColor(isNight ? Color.white : Color.black)
                    .padding(.leading, 10)
                Text(String(currentWeather?.humidity ?? 0))
                    .foregroundColor(isNight ? Color.white : Color.black)
            }
        }
        .padding(.bottom, 50)
    }
}
