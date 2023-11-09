import Alamofire
import UIKit
import AlamofireImage

class WeatherService {

     func handleResponse<T: Decodable>(urlString: String, responseType: T.Type, completion: @escaping (T?, Error?) -> Void) {
            AF.request(urlString).response { response in
                guard let data = response.value else {
                    DispatchQueue.main.async {
                        completion(nil, response.error)
                    }
                    return
                }
//                let body = String(data: data ??  Data(), encoding: .utf8)
//                debugPrint(body! as NSString)

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
    func responseData(urlString: String, completion: @escaping (WeatherModel?, Error?) -> Void) {
                    // WeatherService ile API'yi çağırın
                    handleResponse(urlString:urlString , responseType: WeatherModel.self) { responseModel, error in
                        completion(responseModel, error)
                    }
    }
    func getWeatherIcon(iconCode: String, completion: @escaping (Result<UIImage, Error>) -> Void) {
           let iconURL = "https://openweathermap.org/img/wn/\(iconCode)@2x.png"

           AF.request(iconURL).responseImage { response in
               switch response.result {
               case .success(let image):
                   completion(.success(image))
               case .failure(let error):
                   completion(.failure(error))
               }
           }
       }
        
}
