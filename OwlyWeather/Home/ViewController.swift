//
//  ViewController.swift
//  OwlyWeather
//
//  Created by Roman Korostenskyi on 5/13/19.
//  Copyright © 2019 Korostenskyi. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, CLLocationManagerDelegate {

    @IBOutlet weak var forecastCollectionView: UICollectionView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityNameLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var humidityLabel: UILabel!
    @IBOutlet weak var windSpeedLabel: UILabel!
    @IBOutlet weak var weatherConditionLabel: UILabel!
    @IBOutlet weak var currentWeatherIcon: UIImageView!
    
    private let api = OpenWeatherApi()
    
    private let locationManager = CLLocationManager()
    
    private var forecastList = [ForecastBody]() {
        didSet {
            DispatchQueue.main.async {
                self.forecastCollectionView.reloadData()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let date = Date()
        let calendar = Calendar.current
        let dateString = "\(calendar.component(.day, from: date)).\(calendar.component(.month, from: date)).\(calendar.component(.year, from: date))"
        
        self.dateLabel.text = dateString
        
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        
        if CLLocationManager.locationServicesEnabled() {
            locationManager.delegate = self
            locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
            locationManager.startUpdatingLocation()
        }
        
        currentWeatherIcon.adjustsImageSizeForAccessibilityContentSizeCategory = true
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        
        guard let locValue: CLLocationCoordinate2D = manager.location?.coordinate else { return }
     
        let latitude = locValue.latitude
        let longitude = locValue.longitude
        
        getWeatherForecast(latitude: latitude, longitude: longitude)
        getCurrentWeather(latitude: latitude, longitude: longitude)
    }
    
    private func getCurrentWeather(latitude: Double, longitude: Double) {
        
        let queue = DispatchQueue(label: "CurrentWeather")
        
        queue.async {
            self.api.fetchCurrentWeatherByCoordinates(lat: latitude, lon: longitude) { result in
                
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let weather):
                    guard let temperature = weather.numeriсalParameters?.temperature else { return }
                    guard let humidity = weather.numeriсalParameters?.humidity else { return }
                    guard let windSpeed = weather.wind?.speed else { return }
                    guard let weatherCondition = weather.weatherList![0].title else { return }
                    guard let weatherIconName = weather.weatherList![0].icon else { return }
                    
                    DispatchQueue.main.async {
                        self.temperatureLabel.text = "\(Int(temperature - 273.3))°"
                        self.humidityLabel.text = "\(Int(humidity))"
                        self.windSpeedLabel.text = "\(Int(windSpeed))"
                        self.weatherConditionLabel.text = weatherCondition
                        self.currentWeatherIcon.image = self.getWeatherIcon(name: weatherIconName)
                    }
                }
            }
        }
    }
    
    private func getWeatherForecast(latitude: Double, longitude: Double) {
    
        let queue = DispatchQueue(label: "ForecastWeather")
        
        queue.async {
            self.api.fetchForecastWeatherByCoordinates(lat: latitude, lon: longitude, completion: { result in
                switch result {
                    
                case .failure(let error):
                    print(error)
                    
                case .success(let forecast):
                    guard let city = forecast.city else { return }
                    guard let forecastsResponse = forecast.forecastList else { return }
                    
                    DispatchQueue.main.async {
                        self.cityNameLabel.text = city.name
                    }
                    
                    self.forecastList = forecastsResponse
                }
            })
        }
    }
    

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return forecastList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = forecastCollectionView.dequeueReusableCell(withReuseIdentifier: "forecastCell", for: indexPath) as? ForecastCollectionViewCell
        
        if !(forecastList.isEmpty) {
                cell?.temperatureLabel.text = "\(Int(self.forecastList[indexPath.item].numericalParameters!.temperature! - 273.15))°"
                
                cell?.conditionLabel.text = self.forecastList[indexPath.item].weatherList![0].title
            cell?.forecastWeatherIcon.image = self.getWeatherIcon(name: self.forecastList[indexPath.item].weatherList![0].icon!)
                
                let date = Date(timeIntervalSince1970: self.forecastList[indexPath.item].date!)
                let dateFormatter = DateFormatter()
                
                dateFormatter.dateFormat = "HH:mm"
                
                let dateString = dateFormatter.string(from: date)
                
                cell?.timeLabel.text = dateString
        } else {
            print("Empty")
        }
        
        return cell!
    }
    
    private func getWeatherIcon(name: String) -> UIImage {
        switch name {
        case "01d":
            return UIImage(named: "CleanWeather")!
        
        case "01n":
            return UIImage(named: "CleanWeatherNight")!
            
        case "02d":
            return UIImage(named: "PartlyCloudyDay")!
            
        case "02n":
            return UIImage(named: "Cloud")!
            
        case "03d":
            return UIImage(named: "Cloud")!
            
        case "03n":
            return UIImage(named: "Cloud")!
            
        case "04d":
            return UIImage(named: "Cloud")!
            
        case "04n":
            return UIImage(named: "Cloud")!
            
        case "09d":
            return UIImage(named: "Rainy")!
            
        case "09n":
            return UIImage(named: "Rainy")!
            
        case "10d":
            return UIImage(named: "Rainy")!
            
        case "10n":
            return UIImage(named: "Rainy")!
            
        case "11d":
            return UIImage(named: "Lightning")!
            
        case "11n":
            return UIImage(named: "Lightning")!
            
        case "13d":
            return UIImage(named: "Snow")!
            
        case "13n":
            return UIImage(named: "Snow")!

        default:
            return UIImage(named: "Fog")!
        }
    }
}

