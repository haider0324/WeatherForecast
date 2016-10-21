//
//  WeatherTableViewCell.swift
//  WeatherForecast
//
//  Created by Haider Abbas on 20/10/16.
//  Copyright © 2016 Haider Abbas. All rights reserved.
//

import UIKit

class WeatherTableViewCell: UITableViewCell {
    // MARK: - IBOutlets
    @IBOutlet weak var lblDay: UILabel!
    @IBOutlet weak var lblMinTemp: UILabel!
    @IBOutlet weak var lblMaxTemp: UILabel!
    @IBOutlet weak var lblWeatherInfo: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        lblDay.layer.borderColor = UIColor.grayColor().CGColor
        lblDay.layer.borderWidth = 1.0
        
        lblMinTemp.layer.borderColor = UIColor.grayColor().CGColor
        lblMinTemp.layer.borderWidth = 1.0
        
        lblMaxTemp.layer.borderColor = UIColor.grayColor().CGColor
        lblMaxTemp.layer.borderWidth = 1.0
        
        lblWeatherInfo.layer.borderColor = UIColor.grayColor().CGColor
        lblWeatherInfo.layer.borderWidth = 1.0
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func config(withWeathers weather: [String: AnyObject]) {
        print("\(weather)")
        lblDay.text = weather["dt_txt"] as? String
        let weatherDICT = weather["main"] as! [String : AnyObject]
        if let weatherTemp = (weatherDICT["temp"]!).doubleValue {
            let newTemp = weatherTemp - 273.15
            lblMinTemp.text = String(format: "%.02f°C",newTemp)
        }
        let weatherArray = weather["weather"] as! [[String : AnyObject]]
        
        lblWeatherInfo.text = weatherArray[0]["description"] as? String
        lblMaxTemp.text = weatherArray[0]["main"] as? String
    }

}
