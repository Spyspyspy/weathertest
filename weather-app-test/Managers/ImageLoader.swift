//
//  ImageLoader.swift
//  weather-app-test
//
//  Created by  spy on 17.03.2023.
//

import SwiftUI
import Foundation
import Combine

class ImageLoader: ObservableObject {
    var didChange = PassthroughSubject<Data, Never>()
    var data = Data() {
        didSet {
            didChange.send(data)
        }
    }

    init(urlString:String) {
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data, self != nil else { return }
            DispatchQueue.main.async { 
                self?.data = data
            }
        }
        task.resume()
    }
}
