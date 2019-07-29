//
//  ViewController.swift
//  weatherApp
//
//  Created by Bhagyashree Gawade on 7/25/19.
//  Copyright © 2019 Bhagyashree Gawade. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

class ViewController: UIViewController {
    
    private lazy var weatherView: WeatherView = {
        let view = WeatherView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let gradientLayer = CAGradientLayer()
    var activityIndicator: NVActivityIndicatorView?
    var weatherApiHandler = WeatherApiHandler()
    var timer: Timer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.isNavigationBarHidden = true
        let indicatorSize: CGFloat = 70
        let indicatorFrame = CGRect(x:(view.frame.width - indicatorSize)/2, y: (view.frame.height - indicatorSize)/2, width: indicatorSize, height: indicatorSize)
        activityIndicator = NVActivityIndicatorView(frame: indicatorFrame, type: .lineScale, color: UIColor.white, padding: 20.0)
        activityIndicator?.backgroundColor = .black
        view.addSubview(activityIndicator!)
        
        activityIndicator?.startAnimating()
        
        weatherApiHandler.startTracking()
        
        weatherView.view.layer.addSublayer(gradientLayer)
        
        view.addSubview(weatherView)
        weatherView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        weatherView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        weatherView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        weatherView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
    
        fadeWeatherImage(imageView: weatherView.image)
        
//        timer = Timer.scheduledTimer(timeInterval: 5, target: self, selector: #selector(getWeatherData), userInfo: nil, repeats: true)
        
        weatherApiHandler.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setBlueGradientLayer()
    }
    
    func setWeather(weatherData: Weather) {
        self.weatherView.cityLabel.text = weatherData.locationName
        self.weatherView.image.image = UIImage(named: weatherData.iconName ?? "")
        self.weatherView.weatherLabel.text = weatherData.condition
        self.weatherView.degreeLabel.text = (Int(round(weatherData.temp ?? 0.0))).description
    }
    
    func fadeWeatherImage(imageView: UIImageView){
        let translate = CGAffineTransform(translationX: 0, y: 0)
        let scale = CGAffineTransform(scaleX: 2, y: 2)
        
        UIView.animate(withDuration: 2.0, delay: 2.0, options: .curveEaseOut, animations: {
            imageView.alpha = 0.3
        })
        
        UIView.animate(withDuration: 2.0, delay: 2.0, usingSpringWithDamping: 1.5, initialSpringVelocity: 0.5, animations: {
            imageView.alpha = 1
            imageView.transform = translate.concatenating(scale)
            imageView.centerXAnchor.constraint(equalTo: self.weatherView.centerXAnchor, constant: 100).isActive = true
        })
    }
    
    func setBlueGradientLayer(){
        let topColor = UIColor(red: 95.0/255.0, green: 165.0/255.0, blue: 1.0, alpha: 1.0).cgColor
        let bottomColor = UIColor(red: 72.0/255.0, green: 114.0/255.0, blue: 184.0/255.0, alpha: 1.0).cgColor
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [topColor, bottomColor]
    }
    
    func setGrayGradientLayer(){
        let topColor = UIColor(red: 151.0/255.0, green: 151.0/255.0, blue: 151.0/255.0, alpha: 1.0).cgColor
        let bottomColor = UIColor(red: 72.0/255.0, green: 72.0/255.0, blue: 72.0/255.0, alpha: 1.0).cgColor
        gradientLayer.frame = view.bounds
        gradientLayer.colors = [topColor, bottomColor]
    }
}

extension ViewController: WeatherDelagate {
    func sendWeatherDetails(weatherData: Weather?) {
        setWeather(weatherData: weatherData!)
    }
}
