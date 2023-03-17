//
//  LocationView.swift
//  weather-app-test
//
//  Created by  spy on 17.03.2023.
//

import SwiftUI

struct LocationView: View {
    
    var location: String
    @Binding var isNight: Bool
    var body: some View {
            Text(location + "\n" + Date().getTime())
                .font(.system(size: 32, weight: .medium, design: .default))
                .foregroundColor(isNight ? Color.white : Color.black)
                .padding()
    }
}
