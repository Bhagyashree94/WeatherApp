//
//  Weather.swift
//  weatherApp
//
//  Created by Bhagyashree Gawade on 7/26/19.
//  Copyright © 2019 Bhagyashree Gawade. All rights reserved.
//

import Foundation

class Weather: Codable {
  
    var locationName: String?
    var iconName: String?
    var temp: Double?
    var condition: String?
    
    init(locationName: String?, iconName: String?, temp: Double?, condition: String?) {
        self.locationName = locationName
        self.iconName = iconName
        self.temp = temp
        self.condition = condition
    }
}
