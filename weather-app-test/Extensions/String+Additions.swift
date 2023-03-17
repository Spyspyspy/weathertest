//
//  String+Additions.swift
//  weather-app-test
//
//  Created by spy on 16/03/23.
//

import Foundation

extension String {
    func stringToDate() -> Date {
        let dateString = self
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let date = dateFormatter.date(from: dateString)
        return date ?? Date()
    }
}
