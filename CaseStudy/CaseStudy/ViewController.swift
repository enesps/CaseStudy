//
//  ViewController.swift
//  CaseStudy
//
//  Created by Enes Pusa on 18.10.2023.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var nextPage: UIButton!
    
    @IBOutlet weak var apiKeyText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        nextPage.layer.borderWidth = 1
        nextPage.layer.cornerRadius=17
        nextPage.layer.borderColor = UIColor.white.cgColor
        apiKeyText.layer.borderWidth=3
        apiKeyText.layer.borderColor = UIColor.white.cgColor
        apiKeyText.layer.cornerRadius=10
        
        
    }

    @IBAction func nextPage(_ sender: Any) {
        let vc =  self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
        self.show(vc, sender: nil)
    }
    
}
extension ViewController {
//    func handleDeepLink(_ deepLink : DeepLink){
//        switch deepLink {
//        case .home:
//            presentTabBar(withIndex : 0)
//        case .WeatherDetail:
//            presentTabBar(withIndex : 1)
//            
//        }
//    }
}

