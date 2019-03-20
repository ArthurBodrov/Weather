//
//  Curreb.swift
//  Weather
//
//  Created by  Arthur Bodrov on 17/03/2019.
//  Copyright © 2019  Arthur Bodrov. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON


class CurrentTodayWeather {
    
    private var _cityName: String!
    private var _currentTemp: Double!
    private var _weatherType: String!
    private var _weatherDescription: String!
    
    var cityName: String {
        if _cityName == nil{
            _cityName = ""
        }
        return _cityName
    }
    
    var weatherType: String {
        if _weatherType == nil{
            _weatherType = ""
        }
        return _weatherType
    }
    
    var currentTemp: Double {
        if _currentTemp == nil{
            _currentTemp = 0.0
        }
        return _currentTemp
    }
    
    var weatherDescription: String {
        if _weatherDescription == nil{
            _weatherDescription = ""
        }
        return _weatherDescription
    }
    
    func downloadCurrentWeather(completed: @escaping DownloadComlpete){
        Alamofire.request(API_URL).responseJSON { (response) in
            let result = response.result
            let json = JSON(result.value)
//            print(result.value)
            self._cityName = json["name"].stringValue
            self._weatherType = json["weather"][0]["main"].stringValue
            self._weatherDescription = json["weather"][0]["description"].stringValue
            let downloadedTemp = json["main"]["temp"].double
            self._currentTemp = (downloadedTemp! - 273.15).rounded(toPlaces: 0)
             completed()
        }
       
    }
}
