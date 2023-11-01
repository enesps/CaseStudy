import Foundation
import Alamofire

struct WeatherEndpoint {
    private static let baseURL = "https://api.openweathermap.org/data/2.5"
    static func oneCallWeatherURL(latitude: Double, longitude: Double) -> URL? {
          let urlString = "\(baseURL)/onecall?lat=\(latitude)&lon=\(longitude)&appid=\(Constants.apiKey)"
          return URL(string: urlString)
      }


}
