//
//  ForecastWeatherResponse.swift
//  OwlyWeather
//
//  Created by Roman Korostenskyi on 5/13/19.
//  Copyright © 2019 Korostenskyi. All rights reserved.
//

import Foundation

struct ForecastWeatherResponse: Codable {
    let forecastList: [ForecastBody]?
    let city: City?
    
    private enum CodingKeys: String, CodingKey {
        case forecastList = "list"
        case city
    }
}
