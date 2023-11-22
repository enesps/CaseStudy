//
//  CaseStudyTests.swift
//  CaseStudyTests
//
//  Created by Enes Pusa on 18.10.2023.
//

import XCTest
import CoreLocation
@testable import CaseStudy

final class WeatherViewModelTest: XCTestCase {
    
    var viewModel: WeatherViewModel?
    override func setUp() {
        super.setUp()
        
        // Mock JSON dosyasından verileri okuyun
        if let jsonURL = Bundle(for: type(of: self)).url(forResource: "mockWeather", withExtension: "json"),
           let jsonData = try? Data(contentsOf: jsonURL),
           let mockWeather = try? JSONDecoder().decode(WeatherModel.self, from: jsonData) {
            
            viewModel = WeatherViewModel()
            viewModel?.weatherData = mockWeather
        }
    }
    func testUpdateUITableView() {
        let tableView = UITableView()
        let dailyData = viewModel?.weatherData?.daily
        
        XCTAssertNotNil(dailyData, "Daily Data should not be nil")

        viewModel?.updateUITableView(daily: dailyData!, TableView: tableView)

        // TableView'ın veri kaynağını kontrol edin veya belirli bir hücreyi kontrol edebilirsiniz.
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 0)
    }
    

    
    func testFetchWeatherData() {
        // MockWeatherService kullanarak view modelin fetchWeatherData fonksiyonunu test et
        viewModel?.weatherService = MockWeatherService()

        let expectation = XCTestExpectation(description: "Fetch Weather Data")

        viewModel?.fetchWeatherData(latitude: 37.7749, longitude: -122.4194)

        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            XCTAssertNotNil(self.viewModel?.weatherData)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2.0)
    }

    class MockWeatherService: WeatherService {
        override func responseData(urlString: String, completion: @escaping (WeatherModel?, Error?) -> Void) {
            // Burada mock WeatherModel veya hata oluşturabilirsiniz
            let mockWeather = WeatherModel(lat: 37.7749, lon: -122.4194, timezone: "America/Los_Angeles", timezoneOffset: -25200, current: nil, minutely: nil, hourly: nil, daily: nil)
            completion(mockWeather, nil)
        }
    }

    func testUpdateUICountry() {
        let countryLabel = UILabel()
        viewModel?.updateUICountry(countryUI: countryLabel)
        
        XCTAssertEqual(countryLabel.text, "New York")
    }
    
    func testUpdateUITemperature() {
        let tempLabel = UILabel()
        viewModel?.updateUITemperature(weatherTemp: tempLabel)
        
        XCTAssertEqual(tempLabel.text, "10°") // Mock verideki temp'e göre hesaplandı
    }
    func testUpdateUIWeatherDescription() {
        let weatherDescriptionLabel = UILabel()
        viewModel?.updateUIWeatherDescription(description: "overcast clouds", weatherDescriptionUI: weatherDescriptionLabel)
        
        XCTAssertEqual(weatherDescriptionLabel.text, "overcast clouds")
    }
    
    
    func testUpdateBackgroundImage() {
        let backgroundImageView = UIImageView()
        let condition = "overcast clouds"
        
        viewModel?.updateBackgroundImage(backgroundImageView: backgroundImageView, withCondition: condition)
        
        XCTAssertEqual(backgroundImageView.image, UIImage(named: "weather"))
    }
    
    func testGetDailyModel() {
        // Önce DailyModel'i bir örnek değerle dolduralım
        viewModel?.dailyModel = (viewModel?.weatherData?.daily)!

        // Şimdi getDailyModel'i çağırarak beklenen değeri kontrol edelim
        
        let result = viewModel?.dailyModel.first?.temp?.day

        XCTAssertEqual(result, 284.99, "getDailyModel fonksiyonu beklenen değeri döndürmedi.")
    }
    func testGetWeatherIcon() {
        let expectation = XCTestExpectation(description: "Get Weather Icon")

        viewModel?.getWeatherIcon(iconCode: "01d") { image in
            XCTAssertNotNil(image, "Weather icon should not be nil")
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 5.0)
    }

    
}
