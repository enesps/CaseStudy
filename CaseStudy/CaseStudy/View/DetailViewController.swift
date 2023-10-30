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
                print(self?.model.count)
                let timezone = weatherData.timezone?.components(separatedBy: "/").last?.replacingOccurrences(of: "_", with: " ")
                if let temperature = weatherData.current?.temp {
                    print(temperature)
                    self?.temp.text = "\(String(describing: temperature))"
                }
                self?.country.text = timezone
                
                
                
                
                self?.viewModel.getWeatherIcon(iconCode: (weatherData.current?.weather?.first?.icon)!) { iconImage in
                    if let image = iconImage {
                        
                        DispatchQueue.main.sync {
                            self?.tempImage.image = image
                        }
                    } else {
                        // Hata veya eksik ikon
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
            cell.setTemp(temp: String(describing: dayTemp))
        } else {
            cell.setTemp(temp: "Bilgi yok")
        }
        
        return cell
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.count
    }
    
    
    
}


