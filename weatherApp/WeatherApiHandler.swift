//
//  weatherApiHandler.swift
//  weatherApp
//
//  Created by Bhagyashree Gawade on 7/25/19.
//  Copyright © 2019 Bhagyashree Gawade. All rights reserved.
//

import Foundation
import CoreLocation

protocol WeatherDelagate {
    func sendWeatherDetails(weatherData: Weather?)
}

class WeatherApiHandler: NSObject, CLLocationManagerDelegate {
    
    let APIKey = "de34bf542028bcc1f627536a685eaa23"
    
    var lat = 0.0
    var lon = 0.0
    var locationManager: CLLocationManager!
    var delegate: WeatherDelagate?
    
    func startTracking() {
        locationManager = CLLocationManager()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = 1000
        locationManager.requestAlwaysAuthorization()
        
        if(CLLocationManager.locationServicesEnabled()){
            locationManager.startUpdatingLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let location = locations[0]
        lat = location.coordinate.latitude
        lon = location.coordinate.longitude
        
        getWeatherReport(completionHandler: { (weatherModel, error) in
            DispatchQueue.main.async {
                guard let weather = weatherModel else { return }
                self.delegate?.sendWeatherDetails(weatherData: weather)
            }
        })
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
            print(error)
    }
    
    func getWeatherReport(completionHandler: @escaping (Weather?, Error?) -> Void){
        let url = URL(string: "http://api.openweathermap.org/data/2.5/weather?lat=\(lat)&lon=\(lon)&appid=\(APIKey)&units=metric")!
        
        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            print(response.debugDescription)
            guard let data = data, error == nil else {
                completionHandler(nil, error)
                return
            }
            if let weatherModel = try? JSONSerialization.jsonObject(with: data) as? [String: Any] {
                print(weatherModel)
                let weatherArray = weatherModel["weather"] as? [[String: Any]]
                let tempArray = weatherModel["main"] as? [String: Any]
                let weather = Weather(
                    locationName: weatherModel["name"] as? String,
                    iconName: weatherArray?[0]["icon"] as? String,
                    temp: tempArray?["temp"] as? Double,
                    condition: weatherArray?[0]["main"] as? String )
                completionHandler(weather, nil)
            }
        }
        task.resume()
    }
}
