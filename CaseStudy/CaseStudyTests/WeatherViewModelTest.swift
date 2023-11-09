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
    
    func testFetchWeatherData() {
        let expectation = XCTestExpectation(description: "Fetch Weather Data")
        var viewmodel = WeatherViewModel()
        viewmodel.fetchWeatherData(latitude: 37.7749, longitude: -122.4194)
        viewmodel.didUpdateWeatherData = { weatherData in
            
               
                XCTAssertNotNil(weatherData)
                

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
    
    //    func testUpdateUIWeatherIcon() {
    //        let tempImage = UIImageView()
    //        let image = UIImage(named: "sun_icon") // Örnek bir ikon adı
    //
    //        viewModel?.updateUIWeatherIcon(tempImage: tempImage, image: image?)
    //
    //        XCTAssertEqual(tempImage.image, image)
    //    }
    
    func testUpdateBackgroundImage() {
        let backgroundImageView = UIImageView()
        let condition = "overcast clouds"
        
        viewModel?.updateBackgroundImage(backgroundImageView: backgroundImageView, withCondition: condition)
        
        XCTAssertEqual(backgroundImageView.image, UIImage(named: "weather"))
    }
    //    func testUpdateUITableView() {
    //        let tableView = UITableView()
    //        let dailyData = viewModel?.weatherData?.daily
    //        viewModel?.updateUITableView(daily: dailyData!, TableView: tableView)
    //
    //        // TableView'ın veri kaynağını kontrol edin veya belirli bir hücreyi kontrol edebilirsiniz.
    //        XCTAssertEqual(tableView.numberOfRows(inSection: 0), dailyData!.count)
    //    }
    
    
    //    func testUpdateBackgroundImage_ClearSkyCondition() {
    //        // Given
    //        let viewModel = WeatherViewModel()
    //        let backgroundImageView = UIImageView()
    //        let condition = "clear sky"
    //
    //        // When
    //        viewModel.updateBackgroundImage(backgroundImageView: backgroundImageView, withCondition: condition)
    //
    //        // Then
    //        XCTAssertEqual(backgroundImageView.image, UIImage(named: "clear_sky"))
    //    }
    ////    func testGetWeatherIcon_SunnyIconCode() {
    ////        // Given
    ////        let viewModel = WeatherViewModel()
    ////        let iconCode = "01d"
    ////        let expectation = self.expectation(description: "Icon image downloaded")
    ////
    ////        // When
    ////        var downloadedImage: UIImage?
    ////        viewModel.getWeatherIcon(iconCode: iconCode) { iconImage in
    ////            downloadedImage = iconImage
    ////            expectation.fulfill()
    ////        }
    ////
    ////        // Then
    ////        waitForExpectations(timeout: 5, handler: nil)
    ////        XCTAssertNotNil(downloadedImage)
    ////        // Compare the downloadedImage with the expected image
    ////        XCTAssertEqual(downloadedImage, UIImage(named: "expected_sunny_icon"))
    ////    }
    //    func testUpdateUICountry_UpdateCountryLabel() {
    //        // Given
    //        let viewModel = WeatherViewModel()
    //        let countryLabel = UILabel()
    //
    //        let weatherData = WeatherModel.self
    //
    //        // When
    //        viewModel.updateUICountry(weatherCountry: "Turkey/Istanbul", countryUI: countryLabel)
    //
    //        // Then
    //        XCTAssertEqual(countryLabel.text, "Istanbul")
    //    }
    //
    //    func testUpdateUITemperature_UpdateTemperatureLabel() {
    //        // Given
    //        let viewModel = WeatherViewModel()
    //        let temperatureLabel = UILabel()
    //        let temperatureValue = 274
    //
    //        // When
    //        viewModel.updateUITemperature(temperature: Double(temperatureValue), weatherTemp: temperatureLabel)
    //
    //        // Then
    //        XCTAssertEqual(temperatureLabel.text, "0°")
    //    }
    //    func testUpdateUIWeatherDescription_UpdateDescriptionLabel() {
    //        // Given
    //        let viewModel = WeatherViewModel()
    //        let descriptionLabel = UILabel()
    //        let weatherDescription = "Partly cloudy"
    //
    //        // When
    //        viewModel.updateUIWeatherDescription(description: weatherDescription, weatherDescriptionUI: descriptionLabel)
    //
    //        // Then
    //        XCTAssertEqual(descriptionLabel.text, "Partly cloudy")
    //    }
    //    func testGetWeatherData_ResponseReceived() {
    //        // Given
    //        let viewModel = WeatherViewModel()
    //        let expectation = self.expectation(description: "Weather data received")
    //        var receivedWeatherData: WeatherModel?
    //        var receivedError: Error?
    //
    //        // When
    //        viewModel.getWeatherData { weatherData, error in
    //            receivedWeatherData = weatherData
    //            receivedError = error
    //            expectation.fulfill()
    //        }
    //
    //        // Then
    //        waitForExpectations(timeout: 3, handler: nil)
    //        XCTAssertNotNil(receivedWeatherData, "Expected weather data to be received")
    //        XCTAssertNil(receivedError, "Expected no errors")
    //    }
    
}
