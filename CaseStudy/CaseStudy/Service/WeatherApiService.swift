//
//  WeatherApiService.swift
//  CaseStudy
//
//  Created by Enes Pusa on 24.10.2023.
//

import Alamofire
import CoreLocation

class WeatherApiService {
    static func request<T: Decodable>(_ endpoint: WeatherApiEndPoint, locationService: LocationService, completion: @escaping (Result<T, Error>) -> Void) {
        locationService.onLocationUpdate = { location in
            AF.request(endpoint)  // Use the endpoint directly here
                .validate()
                .responseDecodable(of: T.self) { response in
                    switch response.result {
                    case .success(let value):
                        completion(.success(value))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
        }
        locationService.requestLocationUpdate()
    }



}
