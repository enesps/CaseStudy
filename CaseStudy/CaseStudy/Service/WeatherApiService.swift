import Alamofire
import UIKit

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
}
