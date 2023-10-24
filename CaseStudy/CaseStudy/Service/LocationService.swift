//
//  LocationService.swift
//  CaseStudy
//
//  Created by Enes Pusa on 24.10.2023.
//

import Foundation
import CoreLocation



class LocationService: NSObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()
    var onLocationUpdate: ((CLLocation) -> Void)?

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyNearestTenMeters
    }

    func requestLocationUpdate() {
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }

    // CLLocationManagerDelegate method to handle location updates
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            print(location.coordinate.latitude)
            print(location.coordinate.longitude)
            onLocationUpdate?(location)
        }
    }
}
