//
//  WeatherTableViewCell.swift
//  CaseStudy
//
//  Created by Enes Pusa on 30.10.2023.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {

    
    @IBOutlet private weak var dailyDay: UILabel!
    @IBOutlet private weak var dailyImage: UIImageView!
    @IBOutlet private weak var dailyTemp: UILabel!
    
    @IBOutlet private weak var dailyFeelsTemp: UILabel!
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    func setdailyDay(dayCode :String){
        
        let date = Date(timeIntervalSince1970: TimeInterval(dayCode)!)

        // Date nesnesini gün olarak biçimlendirin
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE"

        let day = dateFormatter.string(from: date)
        self.dailyDay.text = day
        
    }
    func setdailyImage(imageString :UIImage){
        self.dailyImage.image = imageString
    }
    func setdailyTemp(dailyTemp :String){
        
        self.dailyTemp.text = "\(dailyTemp)°"
    }
    func setdailyFeelsTemp(dailyFeelsTemp :String){
        self.dailyFeelsTemp.text = "\(dailyFeelsTemp)°"
    }
   

}
