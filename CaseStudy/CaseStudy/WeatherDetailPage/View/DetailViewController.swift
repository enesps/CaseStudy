import UIKit
import CoreLocation


final class DetailViewController: UIViewController {

    @IBOutlet weak var tempLabel: UILabel!
    
    @IBOutlet weak var maxTempLabel: UILabel!
    @IBOutlet weak var temp: UILabel!
    @IBOutlet weak var weatherTableView: UITableView!
    @IBOutlet weak var temp1: UILabel!
    @IBOutlet weak var country: UILabel!
    @IBOutlet weak var tempImage: UIImageView!
    @IBOutlet weak var weatherDescription: UILabel!
    @IBOutlet weak var backgroundImageView: UIImageView!
    @IBOutlet weak var loadDataActivator: UIActivityIndicatorView!
    
    let viewModel = WeatherViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        setupViewModel()
    }
    
    

    func setupUI() {
        // UI elemanlarını ve delegeleri ayarla
        weatherTableView.delegate = self
        weatherTableView.dataSource = self
    }

    func setupViewModel() {
        // ViewModel tarafından tetiklenen güncelleme bloğunu ayarla
        viewModel.didUpdateWeatherData = { [weak self] weatherData in
            DispatchQueue.main.async {
                guard let self = self, let weatherData = weatherData else { return }

                // TableView ve diğer UI elemanlarını güncelle
                self.updateUI(with: weatherData)
                self.loadDataActivator.stopAnimating()
            }
        }
        // Lokasyon servisi tarafından tetiklenen güncelleme bloğunu ayarla
        viewModel.locationService.onLocationUpdate = { [weak self] location in
            self?.viewModel.fetchWeatherData(latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
        }
    }

    func updateUI(with weatherData: WeatherModel) {
        // TableView ve diğer UI elemanlarını güncelle
        viewModel.updateUITableView(daily: weatherData.daily!, TableView: weatherTableView)
        viewModel.updateUICountry(countryUI: country)

        if let currentWeather = weatherData.current,
           let description = currentWeather.weather?.first?.description,
           let tempUI = temp,
           let weatherDescriptionUI = weatherDescription,
           let condition = weatherData.current?.weather?.first?.description,
              let backgroundImageView = backgroundImageView {
            viewModel.updateUITemperature(weatherTemp: tempUI)
            viewModel.updateUIWeatherDescription(description: description, weatherDescriptionUI: weatherDescriptionUI)
            viewModel.updateBackgroundImage(backgroundImageView: backgroundImageView, withCondition: condition)
            tempLabel.text = " Min"
            maxTempLabel.text = "Max"
        }
    }

}



extension DetailViewController : UITableViewDelegate, UITableViewDataSource {

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = weatherTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! WeatherTableViewCell
        
        // Burada Daily modeli içindeki temp.day kullanılıyor
        if let dayTemp = viewModel.dailyModel[indexPath.row].temp?.day {
            cell.setdailyTemp(dailyTemp: String(describing: Int(dayTemp-273.15)))
            
        } else {
            cell.setdailyTemp(dailyTemp: "Bilgi yok")
        }
        if let dayFeelsLike = viewModel.dailyModel[indexPath.row].temp?.max,
           let dayCode = viewModel.dailyModel[indexPath.row].dt {
            cell.setdailyFeelsTemp(dailyFeelsTemp: String(describing: Int(dayFeelsLike-273.15)))
            cell.setdailyDay(dayCode: String(describing: dayCode))
        }

        if let dayImage = viewModel.dailyModel[indexPath.row].weather?.first?.icon {
            viewModel.getWeatherIcon(iconCode: dayImage) { iconImage in
                if let image = iconImage {
                    
                    DispatchQueue.main.sync {
                        cell.setdailyImage(imageString: image)
                    }
                }
            }
        }
    
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dailyModel.count
    }
}

