import Foundation
import UIKit
import CoreLocation

final class WeatherViewModel {
    private var weatherService: WeatherService
    private var DailyModel = [Daily]()
     var weatherData: WeatherModel?
    var didUpdateWeatherData: ((WeatherModel?) -> Void)?
    var locationService = LocationService()
    private var isLocationUpdated = false
    init(weatherService: WeatherService = WeatherService(), locationService: LocationService = LocationService()) {
        self.weatherService = weatherService
        self.locationService = locationService
    }
    
    

    
    func fetchWeatherData(latitude: Double, longitude: Double) {
        if let weatherURL = WeatherEndpoint.oneCallWeatherURL(latitude: latitude, longitude: longitude) {
            self.weatherService.responseData(urlString: weatherURL.absoluteString) { [weak self] (response, error) in
                guard let self = self else { return }
                self.weatherData = response
                self.didUpdateWeatherData?(self.weatherData)
            }
        }
    }
    
    
    var getDailyModel: [Daily] {
        return DailyModel
    }
    func setDailyModel(DailyModel: [Daily]) {
        self.DailyModel = DailyModel
    }
    
    func updateUITableView(daily: [Daily],TableView:UITableView){
        self.DailyModel = (daily)
        DispatchQueue.main.async {
            TableView.reloadData()
        }
    }
    func updateUICountry(countryUI:UILabel) {
        let weatherCountry = weatherData?.timezone?.components(separatedBy: "/").last?.replacingOccurrences(of: "_", with: " ")
        countryUI.text = weatherCountry
        
    }
    func updateUITemperature(weatherTemp:UILabel) {
        weatherTemp.text = "\(String(describing: Int((weatherData?.current?.temp)! - 273.15)))°"
    }
    func updateUIWeatherDescription(description: String,weatherDescriptionUI: UILabel) {
        weatherDescriptionUI.text = weatherData?.current?.weather?.first?.description?.rawValue
        
    }
    func updateUIWeatherIcon(tempImage:UIImageView,image: UIImage) {
        
        tempImage.image = image
        
    }

    // Hava durumuna göre arka plan resmini güncelle
    func updateBackgroundImage(backgroundImageView:UIImageView,withCondition condition: String) {
        var backgroundName = "default" // Varsayılan arka plan resmi adı
        
        switch condition {
        case "clear sky":
            backgroundName = "clear_sky" // Güneşli hava için resim adı
        case "few clouds":
            backgroundName = "few_clouds" // Bulutlu hava için resim adı
        case "scattered clouds":
            backgroundName = "scattered_clouds"
        case "broken clouds":
            backgroundName = "broken_clouds"
        case "shower rain":
            backgroundName = "shower_rain"
        case "rain":
            backgroundName = "rain"
        case "snow":
            backgroundName = "snow"
        case "mist":
            backgroundName = "mist"
            // Yağmurlu hava için resim adı
        default:
            backgroundName = "weather"
            break
        }
        
        // Arka plan resmini güncelle
        backgroundImageView.image = UIImage(named: backgroundName)
    }
    func getWeatherIcon(iconCode: String, completion: @escaping (UIImage?) -> Void) {
        // Construct the URL for the weather icon
        let iconURL = "https://openweathermap.org/img/wn/\(iconCode)@2x.png"
        
        if let url = URL(string: iconURL) {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let data = data {
                    // Convert the data to a UIImage
                    if let image = UIImage(data: data) {
                        
                        completion(image)
                    } else {
                        completion(nil) // Eğer resim dönüştürülemezse
                    }
                } else {
                    completion(nil) // Eğer veri indirilemezse
                }
            }.resume()
        } else {
            completion(nil) // Eğer URL geçerli değilse
        }
    }

}
