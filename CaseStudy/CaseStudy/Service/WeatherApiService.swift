import Alamofire
import UIKit

class WeatherService {
//    static let shared = WeatherService()
//    
//    private init() { }
    
//    func fetchWeatherData(latitude: Double, longitude: Double, completion: @escaping (WeatherModel?, Error?) -> Void) {
//        let apiKey = "8ddadecc7ae4f56fee73b2b405a63659" // Hava durumu verilerini almak için API anahtarınızı buraya ekleyin.
//        let baseURL = "https://api.openweathermap.org/data/2.5/weather"
//        let parameters: [String: Any] = ["lat": latitude, "lon": longitude, "appid": apiKey]
//        
//        AF.request(baseURL, method: .get, parameters: parameters).responseDecodable(of: WeatherModel.self) { response in
//            switch response.result {
//            case .success(let weatherData):
//                completion(weatherData, nil)
//            case .failure(let error):
//                completion(nil, error)
//            }
//        }
//    }
    static private func handleResponse<T: Decodable>(urlString: String, responseType: T.Type, completion: @escaping (T?, Error?) -> Void) {
            AF.request(urlString).response { response in
                guard let data = response.value else {
                    DispatchQueue.main.async {
                        completion(nil, response.error)
                    }
                    return
                }
                let decoder = JSONDecoder()
                do {
                    let responseObject = try decoder.decode(T.self, from: data!)
                    DispatchQueue.main.async {
                        completion(responseObject, nil)
                    }
                }
                catch {
                    DispatchQueue.main.async {
                        completion(nil, error)
                    }
                }
            }
        }
    static func getGameList( completion: @escaping (WeatherModel?, Error?) -> Void) {
            let urlString = "https://api.openweathermap.org/data/2.5/onecall?lat=-33.8634&lon=151.211&exclude=daily&appid=8ddadecc7ae4f56fee73b2b405a63659"
            handleResponse(urlString: urlString, responseType: WeatherModel.self) { responseModel, error in
                completion(responseModel, error)
            }
        }


}
