import Foundation
import CoreLocation

class WeatherViewModel {
    var weatherData: WeatherModel?
    var onWeatherDataFetched: (() -> Void)?
    
    private let weatherApiService = WeatherApiService()
    private let locationService = LocationService()

    init() {
        locationService.onLocationUpdate = { [weak self] location in
            self?.fetchWeatherData(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        }
    }

    func fetchWeatherData(latitude: Double, longitude: Double) {
        WeatherApiService.request(APIEndpoint.weather(latitude: latitude, longitude: longitude)) { [weak self] (result: Result<WeatherModel, Error>) in
            switch result {
            case .success(let weatherData):
                self?.weatherData = weatherData
                self?.onWeatherDataFetched?()
            case .failure(let error):
                print("API İsteği Başarısız: \(error)")
            }
        }
    }
}
