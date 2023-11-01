import Foundation
import UIKit
import CoreLocation

class WeatherViewModel {
    private var weatherService: WeatherService
    private var locationService: LocationService
    private var DailyModel = [Daily]()
    
    init(weatherService: WeatherService = WeatherService(), locationService: LocationService = LocationService()) {
        self.weatherService = weatherService
        self.locationService = locationService
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
    func updateUICountry(weatherData:WeatherModel,countryUI:UILabel) {
        let weatherCountry = weatherData.timezone?.components(separatedBy: "/").last?.replacingOccurrences(of: "_", with: " ")
        countryUI.text = weatherCountry
        
    }
    func updateUITemperature(temperature: Double,weatherTemp:UILabel) {
        weatherTemp.text = "\(String(describing: Int(temperature - 273.15)))°"
    }
    func updateUIWeatherDescription(description: String,weatherDescriptionUI: UILabel) {
        weatherDescriptionUI.text = description
      
    }
    func updateUIWeatherIcon(tempImage:UIImageView,image: UIImage) {
        DispatchQueue.main.sync {
           tempImage.image = image
        }
    }
    func getWeatherData(completion: @escaping (WeatherModel?, Error?) -> Void) {
        locationService.onLocationUpdate = { [weak self] location in
            // Konum bilgilerini kullanarak API için URL oluşturun
            let weatherEndpoint = WeatherEndpoint.oneCallWeatherURL(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
           
            // WeatherService ile API'yi çağırın
            self?.weatherService.handleResponse(urlString: weatherEndpoint!.absoluteString, responseType: WeatherModel.self) { responseModel, error in
                completion(responseModel, error)
            }
        }
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
