//
//  WeatherApiEndPoint.swift
//  CaseStudy
//
//  Created by Enes Pusa on 24.10.2023.
//
import Foundation
import Alamofire
import CoreLocation

enum WeatherApiEndPoint: URLRequestConvertible {
    case weather(latitude: Double, longitude: Double)

    private var baseURL: URL { URL(string: "https://api.openweathermap.org/data/2.5")! }
    private var apiKey: String { "8ddadecc7ae4f56fee73b2b405a63659" }

    var method: HTTPMethod {
        switch self {
        case .weather:
            return .get
        }
    }

    var path: String {
        switch self {
        case .weather:
            return "/weather"
        }
    }

    var parameters: Parameters {
        var params: Parameters = ["appid": apiKey]
        switch self {
        case .weather(let latitude, let longitude):
            params["lat"] = latitude
            params["lon"] = longitude
        }
        return params
    }

    func asURLRequest() throws -> URLRequest {
        let url = baseURL.appendingPathComponent(path)
        var urlRequest = URLRequest(url: url)
        urlRequest.method = method
        return try URLEncoding.default.encode(urlRequest, with: parameters)
    }
      func endpoint(for endpoint: WeatherApiEndPoint, location: CLLocation) -> WeatherApiEndPoint {
        switch endpoint {
        case .weather:
            return .weather(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        }
    }
}
