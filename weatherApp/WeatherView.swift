//
//  weatherView.swift
//  weatherApp
//
//  Created by Bhagyashree Gawade on 7/25/19.
//  Copyright © 2019 Bhagyashree Gawade. All rights reserved.
//

import Foundation
import UIKit

class WeatherView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        backgroundColor = .darkGray
        
        addSubview(view)
        view.heightAnchor.constraint(equalTo: heightAnchor).isActive = true
        view.widthAnchor.constraint(equalTo: widthAnchor).isActive = true
        
        addSubview(cityLabel)
        cityLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        cityLabel.topAnchor.constraint(equalTo: topAnchor, constant: 80).isActive = true
        
        addSubview(dayLabel)
        dayLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        dayLabel.topAnchor.constraint(equalTo: cityLabel.bottomAnchor, constant: 30).isActive = true
        
        addSubview(image)
        image.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        image.topAnchor.constraint(equalTo: dayLabel.bottomAnchor, constant: 60).isActive = true
        
        addSubview(weatherLabel)
        weatherLabel.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        weatherLabel.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 60).isActive = true
        
        addSubview(degreeStack)
        degreeStack.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
        degreeStack.topAnchor.constraint(equalTo: weatherLabel.bottomAnchor, constant: 30).isActive = true
        
        degreeStack.addArrangedSubview(degreeLabel)
        degreeStack.addArrangedSubview(celciusLabel)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public var view: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    public var cityLabel: UILabel = {
        let cityLabel = UILabel()
        cityLabel.text = "San Fransisco"
        cityLabel.textColor = .white
        cityLabel.font = UIFont.boldSystemFont(ofSize: 20)
        cityLabel.translatesAutoresizingMaskIntoConstraints = false
        return cityLabel
    }()
    
    public var dayLabel: UILabel = {
        let dayLabel = UILabel()
        dayLabel.text = "Friday"
        dayLabel.textColor = .white
        dayLabel.font = UIFont.systemFont(ofSize: 18)
        dayLabel.translatesAutoresizingMaskIntoConstraints = false
        return dayLabel
    }()
    
    public var image: UIImageView = {
        let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 300, height: 200))
        imageView.image = UIImage(named: "rain")
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.layer.masksToBounds = true
        imageView.widthAnchor.constraint(equalToConstant: 150).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    public var weatherLabel: UILabel = {
        let weatherLabel = UILabel()
        weatherLabel.text = "Sunny"
        weatherLabel.textColor = .white
        weatherLabel.font = UIFont.systemFont(ofSize: 18)
        weatherLabel.translatesAutoresizingMaskIntoConstraints = false
        return weatherLabel
    }()
    
    public var degreeStack: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 7
        view.alignment = .fill
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    public var degreeLabel: UILabel = {
        let degreeLabel = UILabel()
        degreeLabel.text = "20"
        degreeLabel.textColor = .white
        degreeLabel.font = UIFont.systemFont(ofSize: 25)
        degreeLabel.translatesAutoresizingMaskIntoConstraints = false
        return degreeLabel
    }()
    
    public var celciusLabel: UILabel = {
        let celciusLabel = UILabel()
        celciusLabel.text = "°C"
        celciusLabel.textColor = .white
        celciusLabel.font = UIFont.systemFont(ofSize: 18)
        celciusLabel.translatesAutoresizingMaskIntoConstraints = false
        return celciusLabel
    }()
}
