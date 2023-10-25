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
    
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var tempImage: UIImageView!
    let locationManager = CLLocationManager()
    
    let viewModel = WeatherViewModel()
    override func viewDidLoad() {
            super.viewDidLoad()
           // makeApi()
            viewModel.onWeatherDataFetched = { [weak self] in
                if let weatherData = self?.viewModel.weatherData {
                    
                    //let temperature = Int(weatherData.main.temp - 273.15)
                    print(weatherData.current.humidity)
                    //let country = String(weatherData.timezone)
                   // self?.country.text = "\(country)"
                   //self?.temp.text = "\(temperature)°C"
                }
            }
        }

}







