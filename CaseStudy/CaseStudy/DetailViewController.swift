//
//  DetailViewController.swift
//  CaseStudy
//
//  Created by Enes Pusa on 23.10.2023.
//

import UIKit
import CoreLocation
import Alamofire


struct Constants {
    static let apiKey = "8ddadecc7ae4f56fee73b2b405a63659"
}



class DetailViewController: UIViewController,CLLocationManagerDelegate {
    @IBOutlet weak var temp: UILabel!
    
    let locationManager = CLLocationManager()
    
    let viewModel = WeatherViewModel()
    let locationService = LocationService()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationService.requestLocationUpdate()
        DispatchQueue.main.async {
            self.viewModel.onWeatherDataFetched = { [weak self] in
                if let weatherData = self?.viewModel.weatherData {
                    let temperature = Int(weatherData.main.temp - 273.15)
                    self?.temp.text = " \(temperature)°C"
                }
            }
        }
        
        locationService.onLocationUpdate = { [weak self] location in
            WeatherApiService.request(WeatherApiEndPoint.weather(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude), locationService: self!.locationService) { (result: Result<WeatherModel, Error>) in
                switch result {
                case .success(let weatherData):
                    self?.viewModel.weatherData = weatherData
                    self?.viewModel.onWeatherDataFetched?()
                case .failure(let error):
                    print("API İsteği Başarısız: \(error)")
                }
            }
        }
        
        
    }
}






