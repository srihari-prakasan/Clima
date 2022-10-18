//
//  ViewController.swift
//  Clima
//
//  Created by Angela Yu on 01/09/2019.
//  Copyright © 2019 App Brewery. All rights reserved.
//

import UIKit

class WeatherViewController: UIViewController,WeatherControlDelegate {

    @IBOutlet weak var conditionImageView: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var searchTextField: UITextField!
    
    var weatherManager=WeatherManeger()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        weatherManager.delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSearchButtonClicked(_ sender: UIButton) {
        if let city=searchTextField.text{
            weatherManager.fetchWeather(cityName: city)
        }
    }
    func updateUI(weather: WeatherModel) {
        DispatchQueue.main.async {
            self.cityLabel.text = weather.city
            self.temperatureLabel.text=String(format: "%.1f", weather.temperature)
        }
        
    }
}

