//
//  OpenWeatherApi.swift
//  OwlyWeather
//
//  Created by Roman Korostenskyi on 5/13/19.
//  Copyright © 2019 Korostenskyi. All rights reserved.
//

import Foundation

class OpenWeatherApi {
    
    private let key = "6beda136c0f88edfc5db7dd0efe3d955"
    private let baseUrl = "https://api.openweathermap.org/data/2.5/"
    
    func fetchCurrentWeatherByCoordinates(lat: Double, lon: Double, closure: @escaping (CurrentWeatherResponse?, Error?) -> Void) {
        
        let urlString = "\(baseUrl)weather?lat=\(lat)&lon=\(lon)&appid=\(key)"
        
        guard let url = URL(string: urlString) else {
            print("ERROR: Error while creating an URL")
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            
            guard let data = data else {
                print("ERROR: There is no data to decode")
                return
            }
            
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            
            do {
                let currentWeatherResponse = try decoder.decode(CurrentWeatherResponse.self, from: data)
                closure(currentWeatherResponse, nil)
            } catch let error {
                print("ERROR: ", error)
                closure(nil, error)
            }
        }.resume()
    }
}
