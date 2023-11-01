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
    @IBOutlet weak var weatherDescription: UILabel!
    @IBOutlet weak var loadDataActivator: UIActivityIndicatorView!
    let locationManager = CLLocationManager()
    let viewModel = WeatherViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        loadDataActivator.startAnimating()
        viewModel.getWeatherData {[weak self] weatherData, error in
            if let weatherData = weatherData, let daily = weatherData.daily {
                if let tableView = self?.weatherTableView,
                   let country = self?.country,
                   let temperature = weatherData.current?.temp,
                   let tempUI = self?.temp,
                   let description = weatherData.current?.weather?.first?.description?.rawValue,
                   let weatherDescription = self?.weatherDescription,
                   let tempImage = self?.tempImage{
                    self?.viewModel.updateUITableView(daily: daily, TableView: tableView)
                    self?.viewModel.updateUICountry(weatherData: weatherData, countryUI: country)
                    self?.viewModel.updateUITemperature(temperature: temperature, weatherTemp: tempUI)
                    self?.viewModel.updateUIWeatherDescription(description: description, weatherDescriptionUI: weatherDescription)
                    self?.viewModel.getWeatherIcon(iconCode: (weatherData.current?.weather?.first?.icon)!) { iconImage in
                        if let image = iconImage {
                            self?.viewModel.updateUIWeatherIcon(tempImage:tempImage, image: image)
                        }
                    }
                }
            }
        }
        weatherTableView.delegate = self
        weatherTableView.dataSource = self
        loadDataActivator.stopAnimating()
    }
}

extension DetailViewController : UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = weatherTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WeatherTableViewCell
        // Burada Daily modeli içindeki temp.day kullanılıyor
        if let dayTemp = viewModel.getDailyModel[indexPath.row].temp?.day {
            cell.setdailyTemp(dailyTemp: String(describing: Int(dayTemp-273.15)))
            
        } else {
            cell.setdailyTemp(dailyTemp: "Bilgi yok")
        }
        if let dayFeelsLike = viewModel.getDailyModel[indexPath.row].temp?.max,
           let dayCode = viewModel.getDailyModel[indexPath.row].dt {
            cell.setdailyFeelsTemp(dailyFeelsTemp: String(describing: Int(dayFeelsLike-273.15)))
            cell.setdailyDay(dayCode: String(describing: dayCode))
        }

        if let dayImage = viewModel.getDailyModel[indexPath.row].weather?.first?.icon {
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
        return viewModel.getDailyModel.count
    }
    
    
    
}


