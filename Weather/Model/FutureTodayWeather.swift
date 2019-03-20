//
//  WeatherEveryThreeHour.swift
//  Weather
//
//  Created by  Arthur Bodrov on 17/03/2019.
//  Copyright © 2019  Arthur Bodrov. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON

class FutureTodayWeather {
    
    private var _firstTemp: Double!
    private var _firstTime: String!
    private var _firstWeatherType: String!
    
    var firstTemp: Double {
        if _firstTemp == nil{
            _firstTemp = 0.0
        }
        return _firstTemp
    }
    
    var firstTime: String {
        if _firstTime == nil{
            _firstTime = ""
        }
        return _firstTime
    }
    
    var firstWeatherType: String{
        if _firstWeatherType == nil{
            _firstWeatherType = ""
        }
        return _firstWeatherType
    }
    
    private var _secondTemp: Double!
    private var _secondTime: String!
    private var _secondWeatherType: String!
    
    var secondTemp: Double {
        if _secondTemp == nil{
            _secondTemp = 0.0
        }
        return _secondTemp
    }
    
    var secondTime: String {
        if _secondTime == nil{
            _secondTime = ""
        }
        return _secondTime
    }
    
    var secondWeatherType: String{
        if _secondWeatherType == nil{
            _secondWeatherType = ""
        }
        return _secondWeatherType
    }
    
    private var _thirdTemp: Double!
    private var _thirdTime: String!
    private var _thirdWeatherType: String!
    
    var thirdTemp: Double {
        if _thirdTemp == nil{
            _thirdTemp = 0.0
        }
        return _thirdTemp
    }
    
    var thirdTime: String {
        if _thirdTime == nil{
            _thirdTime = ""
        }
        return _thirdTime
    }
    
    var thirdWeatherType: String{
        if _thirdWeatherType == nil{
            _thirdWeatherType = ""
        }
        return _thirdWeatherType
    }
    
    private var _fourthTemp: Double!
    private var _fourthTime: String!
    private var _fourthWeatherType: String!
    
    var fourthTemp: Double {
        if _fourthTemp == nil{
            _fourthTemp = 0.0
        }
        return _fourthTemp
    }
    
    var fourthTime: String {
        if _fourthTime == nil{
            _fourthTime = ""
        }
        return _fourthTime
    }
    
    var fourthWeatherType: String{
        if _fourthWeatherType == nil{
            _fourthWeatherType = ""
        }
        return _fourthWeatherType
    }
    func downloadFutureWeather(completed: @escaping DownloadComlpete){
        Alamofire.request(API_URL_2).responseJSON { (responce) in
            let result = responce.result
            let json = JSON(result.value)
//            print(json)
            
            
            let firstTempDownloaded = json["list"][1]["main"]["temp"].double
            self._firstTemp = (firstTempDownloaded! - 273.15).rounded(toPlaces: 0)
            
            let secondTempDownloaded = json["list"][2]["main"]["temp"].double
            self._secondTemp = (secondTempDownloaded! - 273.15).rounded(toPlaces: 0)
            
            let thirdTempDownloaded = json["list"][3]["main"]["temp"].double
            self._thirdTemp = (thirdTempDownloaded! - 273.15).rounded(toPlaces: 0)
            
            let fourthTempDownloaded = json["list"][4]["main"]["temp"].double
            self._fourthTemp = (fourthTempDownloaded! - 273.15).rounded(toPlaces: 0)
            
            
            let firstJSONDate = json["list"][1]["dt"].double
            self._firstTime = Date(timeIntervalSince1970: firstJSONDate!).hourAndMinute()
            
            let secondJSONDate = json["list"][2]["dt"].double
            self._secondTime = Date(timeIntervalSince1970: secondJSONDate!).hourAndMinute()
            
            let thirdJSONDate = json["list"][3]["dt"].double
            self._thirdTime = Date(timeIntervalSince1970: thirdJSONDate!).hourAndMinute()
            
            let fourthJSONDate = json["list"][4]["dt"].double
            self._fourthTime = Date(timeIntervalSince1970: fourthJSONDate!).hourAndMinute()
            
            
            self._firstWeatherType = json["list"][1]["weather"][0]["main"].stringValue
            
            self._secondWeatherType = json["list"][2]["weather"][0]["main"].stringValue
            
            self._thirdWeatherType = json["list"][3]["weather"][0]["main"].stringValue
            
            self._fourthWeatherType = json["list"][4]["weather"][0]["main"].stringValue
    
            
            completed()
        }
        
    }
    
}
