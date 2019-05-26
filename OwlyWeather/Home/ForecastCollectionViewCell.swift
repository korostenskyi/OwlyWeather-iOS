//
//  ForecastCollectionViewCell.swift
//  OwlyWeather
//
//  Created by Roman Korostenskyi on 5/26/19.
//  Copyright © 2019 Korostenskyi. All rights reserved.
//

import UIKit

class ForecastCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var conditionLabel: UILabel!
    @IBOutlet weak var forecastWeatherIcon: UIImageView!
}
