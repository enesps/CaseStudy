//
//  DetailViewController.swift
//  CaseStudy
//
//  Created by Enes Pusa on 23.10.2023.
//

import UIKit
import CoreLocation
import Alamofire





class DetailViewController: UIViewController,CLLocationManagerDelegate{
    @IBOutlet weak var temp: UILabel!
    

    @IBOutlet weak var temp1: UILabel!
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var tempImage: UIImageView!
    let locationManager = CLLocationManager()
   
    @IBOutlet var tableView: UITableView!

    var viewModel = WeatherViewModel()
    
    // Örnek bir günlük hava durumu veri yapısı
    struct DailyWeather {
        let date: String
        let temperature: String
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getWeatherData { weatherData, error in



            if let weatherData = weatherData {
                
                let timezone = weatherData.timezone?.components(separatedBy: "/").last?.replacingOccurrences(of: "_", with: " ")
                if let temperature = weatherData.current?.temp {
                    print(temperature)
                    self.temp.text = "\(String(describing: temperature))"
                }
                self.country.text = timezone
                


                self.viewModel.getWeatherIcon(iconCode: (weatherData.current?.weather?.first?.icon)!) { iconImage in
                    if let image = iconImage {
                        
                        DispatchQueue.main.sync {
                            self.tempImage.image = image
                        }
                    } else {
                        // Hata veya eksik ikon
                    }
                }
 




            } else if let error = error {
                
                print("Error: \(error.localizedDescription)")
            }
            
        }


    }

      

  }

