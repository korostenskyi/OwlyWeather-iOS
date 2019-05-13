//
//  ForecastBody.swift
//  OwlyWeather
//
//  Created by Roman Korostenskyi on 5/13/19.
//  Copyright © 2019 Korostenskyi. All rights reserved.
//

import Foundation

struct ForecastBody: Codable {
    let date: Double?
    let numericalParameters: NumericalParameters?
    let weatherList: [Weather]?
    let wind: Wind?
    
    private enum CodingKeys: String, CodingKey {
        case date = "dt"
        case numericalParameters = "main"
        case weatherList = "weather"
        case wind
    }
}
