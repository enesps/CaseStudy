//
//  WeatherViewModel.swift
//  CaseStudy
//
//  Created by Enes Pusa on 24.10.2023.
//

class WeatherViewModel {
    var weatherData: WeatherModel?
    var onWeatherDataFetched: (() -> Void)?

    func fetchWeatherData(latitude: Double, longitude: Double, locationService: LocationService) {  // Add locationService parameter
        
        print("sjhdsdfhjksdflkj")
        print(latitude)
        print(longitude)
        
        WeatherApiService.request(WeatherApiEndPoint.weather(latitude: latitude, longitude: longitude), locationService: locationService) { [weak self] (result: Result<WeatherModel, Error>) in
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
