//
//  NumericalParameters.swift
//  OwlyWeather
//
//  Created by Roman Korostenskyi on 5/13/19.
//  Copyright © 2019 Korostenskyi. All rights reserved.
//

import Foundation

struct NumericalParameters: Codable {
    let temperature: Double?
    let pressure: Double?
    let humidity: Double?
    
    private enum CodingKeys: String, CodingKey {
        case temperature = "temp"
        case pressure
        case humidity
    }
}
