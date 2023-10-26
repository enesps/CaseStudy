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
  

    var viewModel = WeatherViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        WeatherService.getGameList { model, error in
            print(model?.current?.temp)
        }
//        viewModel.fetchWeatherData { (weatherData, error) in
//            if let weatherData = weatherData {
//                DispatchQueue.main.async {
//                    self.temp.text = "\(weatherData.current?.humidity)°C" // Örnek: Sıcaklık bilgisini görüntüleme
//                       }
//            } else if let error = error {
//                // Hata durumunu ele alın.
//                print("error\(error)")
//            }
//        }
    }
}
