//
//  OpenWeatherApi.swift
//  OwlyWeather
//
//  Created by Roman Korostenskyi on 5/13/19.
//  Copyright © 2019 Korostenskyi. All rights reserved.
//

import Foundation

enum OpenWeatherError: Error {
    case noDataAvailable
    case canNotProcessData
}

class OpenWeatherApi {
    
    private let key = "6beda136c0f88edfc5db7dd0efe3d955"
    private let baseUrl = "https://api.openweathermap.org/data/2.5/"
    
    private let decoder: JSONDecoder
    
    init() {
        decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase
    }
    
    func fetchCurrentWeatherByCoordinates(lat: Double, lon: Double, completion: @escaping(Result<CurrentWeatherResponse, OpenWeatherError>) -> Void) {
        
        let urlString = "\(baseUrl)weather?lat=\(lat)&lon=\(lon)&appid=\(key)"
        
        guard let url = URL(string: urlString) else {
            print("ERROR: Error while creating an URL")
            fatalError()
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, _) in
            
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            
            do {
                let currentWeatherResponse = try self.decoder.decode(CurrentWeatherResponse.self, from: jsonData)
                completion(.success(currentWeatherResponse))
            } catch {
                completion(.failure(.canNotProcessData))
            }
        }
        
        dataTask.resume()
    }
    
    func fetchForecastWeatherByCoordinates(lat: Double, lon: Double, completion: @escaping(Result<ForecastWeatherResponse, OpenWeatherError>) -> Void) {
        
        let urlString = "\(baseUrl)forecast?lat=\(lat)&lon=\(lon)&appid=\(key)"
        
        guard let url = URL(string: urlString) else {
            print("ERROR: Error while creating forecast url")
            fatalError()
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { (data, _, _) in
            
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            
            do {
                let forecastWeatherResponse = try self.decoder.decode(ForecastWeatherResponse.self, from: jsonData)
                completion(.success(forecastWeatherResponse))
            } catch {
                completion(.failure(.canNotProcessData))
            }
        }
        
        dataTask.resume()
    }
}
