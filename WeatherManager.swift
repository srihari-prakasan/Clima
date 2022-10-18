//
//  WeatherManager.swift
//  Clima
//
//  Created by Trenser-01 on 07/10/22.
//  Copyright © 2022 App Brewery. All rights reserved.
//

import Foundation

protocol WeatherControlDelegate{
    func updateUI(weather: WeatherModel)
}
struct WeatherManeger{
    let appUrl="https://api.openweathermap.org/data/2.5/weather?&appid=1be73ad6fed67a2a313cd7835b34ed91&units=metric"
    
    var delegate: WeatherControlDelegate?
    
    func fetchWeather(cityName: String){
        let urlString="\(appUrl)&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    func performRequest(urlString: String){
        //create url
        if let url=URL(string: urlString){
            //create session
            let session=URLSession(configuration: .default)
            
            //give task to the session
            
            let task=session.dataTask(with: url, completionHandler: handle(data: response: error:))
            task.resume()
        }
    }
    func handle(data: Data?,response: URLResponse?,error: Error?){
        
        if error != nil{
            print(error!)
            return
        }
        
        if let safeData=data{
            parseJSON(weatherData: safeData)
        }
        
    }
    func parseJSON(weatherData: Data){
        let decoder=JSONDecoder()
        do{
            let decodedData=try decoder.decode(WeatherData.self,from: weatherData)
            print("City Name   :",decodedData.name)
            let city=decodedData.name
            print("Temperature :",decodedData.main.temp,"Celcius")
            let temp=decodedData.main.temp
            print("Description :",decodedData.weather[0].description)
            let weather=WeatherModel(city: city,temperature: temp)
            self.delegate?.updateUI(weather: weather)
        }catch{
            print("No city found")
        }
    }
}
