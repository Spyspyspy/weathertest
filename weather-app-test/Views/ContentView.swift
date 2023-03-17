//
//  ContentView.swift
//  weather-app-test
//
//  Created by spy on 16/03/23.
//

import SwiftUI

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ContentView: View {
    @State private var isNight = false
    
    @ObservedObject private var viewModel: MainViewModel
    
    init() {
       viewModel = MainViewModel()
    }
    
    
    //MARK: ContentView
    var body: some View {
        
        NavigationView {
           
                ZStack {
                    BackgroundView(isNight: $isNight)
                    ScrollView {
                    //MARK: Main Stack
                        VStack {
                            LocationView(location: (viewModel.currentWeatherDataSource?.location?.name ?? "") + ", " + (viewModel.currentWeatherDataSource?.location?.country ?? "") ?? "London", isNight: $isNight)
                                .padding(.top, 15)
                            
                            MainTemperatureView(isNight: $isNight, currentWeather: viewModel.currentWeatherDataSource?.current, weatherImage: isNight ? ImageNames.moonAndStars.rawValue : ImageNames.cloudAndSun.rawValue , date: Float(viewModel.currentWeatherDataSource?.current?.tempC ?? 0))
                                .padding(.bottom, 50)
                            
                            Spacer()
                            
                            ScrollView(.horizontal) {
                                HStack(spacing: 30) {
                                    
                                    ForEach(0..<(viewModel.currentWeatherDataSource?.forecast?.forecastday?.count ?? 0), id: \.self) {
                                        
                                        DailyWeatherView(withForecaset: (viewModel.currentWeatherDataSource?.forecast?.forecastday?[$0])!)
                                    }
                                }
                            }
                            Spacer()
                        }
                    }.onAppear(perform: {
                        viewModel.callForecastAPI()
                    })
                
            }.navigationBarHidden(true)
        }
    }
}



struct BackgroundView: View {
    @Binding var isNight: Bool
    var body: some View {
        LinearGradient(gradient: Gradient(colors: [isNight ? .black : .blue,
                                                   isNight ? .white : Color("lightBlue")])
                       ,startPoint: .topLeading, endPoint: .bottomTrailing)
            .edgesIgnoringSafeArea(.all)
    }
}

//MARK: Main weather icon and data.
struct MainTemperatureView: View {
    @Binding var isNight: Bool
    var currentWeather: Current?
    var weatherImage: String
    var date: Float
    var body: some View {
        VStack(spacing: 5) {
            AsyncImageTemplate(url:URL(string: "https:" + (currentWeather?.condition?.icon ?? "") )) {
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
            
            Text(currentWeather?.condition?.text ?? "status")
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

struct LocationView: View {
    
    var location: String
    @Binding var isNight: Bool
    var body: some View {
        NavigationLink(destination: CityListingView()) {
            Text(location + "\n" + Date().getTime())
                .font(.system(size: 32, weight: .medium, design: .default))
                .foregroundColor(isNight ? Color.white : Color.black)
                .padding()
        }
    }
}
