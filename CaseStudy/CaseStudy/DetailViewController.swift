//
//  DetailViewController.swift
//  CaseStudy
//
//  Created by Enes Pusa on 23.10.2023.
//

import UIKit
import CoreLocation
import Alamofire

struct WeatherData: Codable {
    let main: Main
}

struct Main: Codable {
    let temp: Double
}

struct Constants {
     static let apiKey = "8ddadecc7ae4f56fee73b2b405a63659"
}



class DetailViewController: UIViewController,CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        locationManager.delegate = self
                locationManager.requestWhenInUseAuthorization()
                locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
                locationManager.startUpdatingLocation()
        
    }
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else {
            return
        }
        
        fetchWeatherDataWithLocation(location: location)
    }

    func fetchWeatherDataWithLocation(location: CLLocation) {
        let latitude = location.coordinate.latitude
        let longitude = location.coordinate.longitude

        let apiUrl = "https://api.openweathermap.org/data/2.5/weather?lat=\(latitude)&lon=\(longitude)&appid=\(Constants.apiKey)"

        AF.request(apiUrl).responseData { response in
            switch response.result {
                        case .success:
                            if let data = response.data,
                               let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                               let main = json["main"] as? [String: Any],
                               let temp = main["temp"] as? Double {
                                print("Sıcaklık: \(Int((temp-273)))°C")
                            } else {
                                print("JSON verileri işlenemedi.")
                            }
                        case .failure(let error):
                            print("API isteği başarısız oldu: \(error)")
                        }
        }
    }
}
