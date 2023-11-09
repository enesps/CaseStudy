//
//  AppDelegate.swift
//  CaseStudy
//
//  Created by Enes Pusa on 18.10.2023.
//

import UIKit
import CoreLocation
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    

    let locationManager = CLLocationManager()

       func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
           // Step 3: request authorization
           //locationManager.requestWhenInUseAuthorization()
           //or
           locationManager.requestAlwaysAuthorization()
           return true
       }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
//    func application(_ app :UIApplication, open url: URL,options: [UIApplication.OpenURLOptionsKey: Any] = [:]) -> Bool {
//        guard let components = NSURLComponents(url: url, resolvingAgainstBaseURL: true),
//                let host = components.host else {
//            print("Invalid URL")
//            return false
//        }
//        print("components : \(components)")
//        guard let deepLink = DeepLink(rawValue: host) else {
//            print("Deeplink not found \(host)")
//            return false
//        }
//        ViewController.handleDeepLink(deepLink)
//        return true
//    }


}

