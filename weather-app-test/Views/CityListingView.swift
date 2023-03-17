//
//  CityListingView.swift
//  weather-app-test
//
//  Created by spy on 16/03/23.
//

import SwiftUI

struct CityListingView_Previews: PreviewProvider {
    static var previews: some View {
        CityListingView()
            .previewDevice("iPhone 11")
    }
}

struct CityListingView: View {
    
    @State public var setCity: (() -> Void)?
   
    
    var body: some View {
        NavigationView {
            List(cities) {
                city in
                    CityRow(city: city)
                       
            }
        }.accentColor(.black)
    }
}
