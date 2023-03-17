//
//  ContentView.swift
//  weather-app-test
//
//  Created by spy on 16/03/23.
//

import SwiftUI



struct ContentView: View {
    @State private var isNight = false
    
    @ObservedObject private var viewModel =  MainViewModel()
    
    //MARK: ContentView
    var body: some View {
        ZStack {
            if (viewModel.viewModelStatus == MainViewModelStatus.loading) {
                BackgroundView(isNight: $isNight)
            } else {
                NavigationView {
                    ZStack {
                        BackgroundView(isNight: $isNight)
                        ScrollView {
                            VStack {
                                LocationView(location: (viewModel.currentWeatherDataSource?.location.name ?? "") + ", " + (viewModel.currentWeatherDataSource?.location.country ?? "") , isNight: $isNight)
                                    .padding(.top, 0)
                                
                                MainTemperatureView(isNight: $isNight, currentWeather: viewModel.currentWeatherDataSource?.current, weatherImage: isNight ? ImageNames.moonAndStars.rawValue : ImageNames.cloudAndSun.rawValue , date: Float(viewModel.currentWeatherDataSource?.current.tempC ?? 0))
                                    .padding(.bottom, 50)
                                
                                Spacer()
                                
                                ScrollView(.horizontal) {
                                    HStack(spacing: 30) {
                                        
                                        ForEach(0..<(viewModel.currentWeatherDataSource?.forecast.forecastday.count ?? 0), id: \.self) {
                                            
                                            DailyWeatherView(withForecaset: (viewModel.currentWeatherDataSource?.forecast.forecastday[$0])!)
                                        }
                                    }
                                }
                                Spacer()
                            }
                        }
                        
                    }.navigationBarHidden(true)
                }
            }
        }.onAppear(perform: {
            viewModel.callForecastAPI()
        })
        .accentColor(.black)
    }
}


