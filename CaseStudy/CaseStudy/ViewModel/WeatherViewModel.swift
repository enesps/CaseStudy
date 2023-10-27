import Foundation
import UIKit
import CoreLocation

class WeatherViewModel {
       private var weatherService: WeatherService
    private var locationService: LocationService
        
    init(weatherService: WeatherService = WeatherService(), locationService: LocationService = LocationService()) {
        self.weatherService = weatherService
        self.locationService = locationService
    }
    //    private var locationService: LocationService
    //
    //    init(weatherService: WeatherService = WeatherService.shared, locationService: LocationService = LocationService.shared) {
    //        self.weatherService = weatherService
    //        self.locationService = locationService
    //    }
    //
    //    func fetchWeatherData(completion: @escaping (WeatherModel?, Error?) -> Void) {
    //        locationService.startUpdatingLocation()
    //        locationService.didUpdateLocation = { [weak self] location in
    //            // Konum bilgilerini alın ve WeatherService ile hava durumu verilerini çekin.
    //            self?.weatherService.fetchWeatherData(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude) { (weatherData, error) in
    //                completion(weatherData, error)
    //            }
    //        }
    //    }
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
