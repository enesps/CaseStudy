import UIKit
import Lottie


class LaunchScreen: UIViewController {



    @IBOutlet weak var lottieAnimation: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        let animationView = LottieAnimationView(name: "weatherLottie")
           animationView.translatesAutoresizingMaskIntoConstraints = false
           view.addSubview(animationView)
        NSLayoutConstraint.activate([
              animationView.topAnchor.constraint(equalTo: view.topAnchor),
              animationView.leftAnchor.constraint(equalTo: view.leftAnchor),
              animationView.rightAnchor.constraint(equalTo: view.rightAnchor),
              animationView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            ])

            animationView.loopMode = .loop
            animationView.play()
         
//        // AnimationView oluşturun ve ayarlarını yapın
//        let animationView = LottieAnimationView(name: "weatherLottie") // "lottie" yerine animasyon dosyasının adını kullanın
//        animationView.frame = lottieAnimation.bounds
//        animationView.contentMode = .scaleAspectFit // Animasyonun boyutunu görüntülemeye sığacak şekilde ayarlayın
//
//        // AnimationView'i UIView'e ekleyin
//        lottieAnimation.addSubview(animationView)
//
//        // Animasyonu başlatın
//        animationView.play()
    }
}
