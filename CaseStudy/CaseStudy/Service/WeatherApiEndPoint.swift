import Foundation
import Alamofire

struct WeatherEndpoint {
    private static let baseURL = "https://api.openweathermap.org/data/2.5"
    private static let apiKey = "8ddadecc7ae4f56fee73b2b405a63659"


    static func oneCallWeatherURL(latitude: Double, longitude: Double) -> URL? {
          let urlString = "\(baseURL)/onecall?lat=\(latitude)&lon=\(longitude)&appid=\(apiKey)"
          return URL(string: urlString)
      }


}
