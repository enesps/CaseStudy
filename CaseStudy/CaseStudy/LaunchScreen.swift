import UIKit
import Lottie

class LaunchScreen: UIViewController {

    @IBOutlet weak var animationContainerView: UIView! // UIView'e uygun bir isim verin

    @IBOutlet weak var lottieAnimation: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // AnimationView oluşturun ve ayarlarını yapın
        let animationView = AnimationView(name: "weatherLottie") // "lottie" yerine animasyon dosyasının adını kullanın
        animationView.frame = animationContainerView.bounds
        animationView.contentMode = .scaleAspectFit // Animasyonun boyutunu görüntülemeye sığacak şekilde ayarlayın

        // AnimationView'i UIView'e ekleyin
        animationContainerView.addSubview(animationView)

        // Animasyonu başlatın
        animationView.play()
    }
}
