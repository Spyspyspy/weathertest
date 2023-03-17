//
//  CityRow.swift
//  weather-app-test
//
//  Created by spy on 16/03/23.
//

import SwiftUI

struct CityRow: View {
    var city: City
    @State var dest2Active: Bool = false
    
    var body: some View {
        NavigationLink(isActive: $dest2Active, destination: {
            ContentView()
        }, label: {
            HStack {
                Text(city.name)
                    .onTapGesture {
                        UserDefaults.standard.set(city.name, forKey: "currentCity")
                        dest2Active = true
                    }
            }
        })
    }
}

struct CityRow_Previews: PreviewProvider {
    static var previews: some View {
        CityRow(city: cities[0]).previewDevice("iPhone 11").previewLayout(.fixed(width: 500, height: 100))
    }
}
