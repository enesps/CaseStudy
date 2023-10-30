//
//  WeatherTableViewCell.swift
//  CaseStudy
//
//  Created by Enes Pusa on 30.10.2023.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    @IBOutlet private weak var temp: UILabel!
    

    override func awakeFromNib() {
        
        super.awakeFromNib()
        
    }
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func setTemp(temp :String){
        self.temp.text = temp
    }

}
