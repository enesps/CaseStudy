//
//  WeatherModel.swift
//  CaseStudy
//
//  Created by Enes Pusa on 24.10.2023.
//

import Foundation

struct WeatherModel: Codable {
    let main: Main
}

struct Main: Codable {
    let temp: Double
}
