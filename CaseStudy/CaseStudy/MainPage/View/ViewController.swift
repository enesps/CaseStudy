//
//  ViewController.swift
//  CaseStudy
//
//  Created by Enes Pusa on 18.10.2023.
//

import UIKit
import Lottie

class ViewController: UIViewController {
    
    @IBOutlet weak var nextPage: UIButton!
    
    @IBOutlet weak var apiKeyText: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

//        let animationView = LottieAnimationView(name: "weatherLottie")
//           animationView.translatesAutoresizingMaskIntoConstraints = false
//           view.addSubview(animationView)
//        NSLayoutConstraint.activate([
//              animationView.topAnchor.constraint(equalTo: view.topAnchor),
//              animationView.leftAnchor.constraint(equalTo: view.leftAnchor),
//              animationView.rightAnchor.constraint(equalTo: view.rightAnchor),
//              animationView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
//            ])
//
//            animationView.loopMode = .loop
//            animationView.play()
        
        // Do any additional setup after loading the view.
        nextPage.layer.borderWidth = 1
        nextPage.layer.cornerRadius=17
        nextPage.layer.borderColor = UIColor.white.cgColor
        apiKeyText.layer.borderWidth=3
        apiKeyText.layer.borderColor = UIColor.white.cgColor
        apiKeyText.layer.cornerRadius=10
    
    }
    
    @IBAction func nextPage(_ sender: Any) {
        if apiKeyText.text == Constants.apiKey{
            let vc =  self.storyboard?.instantiateViewController(withIdentifier: "DetailViewController") as! DetailViewController
            self.show(vc, sender: nil)
        }else{
            let alertController = UIAlertController(title: "Invalid Api Key", message: "Please make sure your Api key to correct sign in", preferredStyle: .alert)
            
            let okAction = UIAlertAction(title: "Try Again", style: .default) { (action) in
            }
            alertController.addAction(okAction)

                    present(alertController, animated: true, completion: nil)
        }
        
    }
}

