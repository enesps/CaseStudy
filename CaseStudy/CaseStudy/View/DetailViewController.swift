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
    
    @IBOutlet weak var weatherTableView: UITableView!
    
    @IBOutlet weak var temp1: UILabel!
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var tempImage: UIImageView!
    let locationManager = CLLocationManager()
    @IBOutlet weak var weatherDescription: UILabel!
    var model = [Daily]()
    var viewModel = WeatherViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.getWeatherData {[weak self] weatherData, error in
            if let weatherData = weatherData, let emt = weatherData.daily {
                self?.model = (emt)
                DispatchQueue.main.async {
                    self?.weatherTableView.reloadData()
                }
                let timezone = weatherData.timezone?.components(separatedBy: "/").last?.replacingOccurrences(of: "_", with: " ")
                if let temperature = weatherData.current?.temp {
                    print(temperature)
                    self?.temp.text = "\(String(describing: Int(temperature-273.15)))°"
                }
                self?.country.text = timezone
                
                
                self?.weatherDescription.text = weatherData.current?.weather?.first?.description?.rawValue
                
                self?.viewModel.getWeatherIcon(iconCode: (weatherData.current?.weather?.first?.icon)!) { iconImage in
                    if let image = iconImage {
                        
                        DispatchQueue.main.sync {
                            self?.tempImage.image = image
                        }
                    }
                }
                
            } else if let error = error {
                
                print("Error: \(error.localizedDescription)")
            }
            
        }
        
        
        
        weatherTableView.delegate = self
        weatherTableView.dataSource = self
        
    }
    
    
}
extension DetailViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = weatherTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WeatherTableViewCell
        // Burada Daily modeli içindeki temp.day kullanılıyor
        if let dayTemp = model[indexPath.row].temp?.day {
            cell.setdailyTemp(dailyTemp: String(describing: Int(dayTemp-273.15)))
            
        } else {
            cell.setdailyTemp(dailyTemp: "Bilgi yok")
        }
        if let dayFeelsLike = model[indexPath.row].temp?.max,
           let dayCode = model[indexPath.row].dt {
            cell.setdailyFeelsTemp(dailyFeelsTemp: String(describing: Int(dayFeelsLike-273.15)))
            cell.setdailyDay(dayCode: String(describing: dayCode))
        }

        if let dayImage = model[indexPath.row].weather?.first?.icon {
            viewModel.getWeatherIcon(iconCode: dayImage) { iconImage in
                if let image = iconImage {
                    
                    DispatchQueue.main.sync {
                        cell.setdailyImage(imageString: image)
                    }
                }
            }
        }
        
        
        
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    
    
}


