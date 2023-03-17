//
//  Cities.swift
//  weather-app-test
//
// Created by spy on 16/03/23.
//

import Foundation


class City: Identifiable, ObservableObject {
    var id: Int
    var name: String
    
    init(id: Int, name: String) {
        self.id = id
        self.name = name
    }
}

let cities = [
    City(id: 1, name: "Paris"),
    City(id: 2, name: "Tokyo"),
    City(id: 3, name: "London"),
]
