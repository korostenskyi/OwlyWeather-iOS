//
//  Weather.swift
//  OwlyWeather
//
//  Created by Roman Korostenskyi on 5/13/19.
//  Copyright © 2019 Korostenskyi. All rights reserved.
//

import Foundation

struct Weather: Codable {
    let title: String?
    let description: String?
    let icon: String?
    
    private enum CodingKeys: String, CodingKey {
        case title = "main"
        case description
        case icon
    }
}
