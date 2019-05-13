//
//  CurrentWeatherResponse.swift
//  OwlyWeather
//
//  Created by Roman Korostenskyi on 5/13/19.
//  Copyright © 2019 Korostenskyi. All rights reserved.
//

import Foundation

struct CurrentWeatherResponse: Codable {
    let cityName: String?
    let numeriсalParameters: NumericalParameters?
    let weatherList: [Weather]?
    let wind: Wind?
    
    private enum CodingKeys: String, CodingKey {
        case cityName = "name"
        case numeriсalParameters = "main"
        case weatherList = "weather"
        case wind
    }
}
