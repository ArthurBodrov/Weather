//
//  Extras.swift
//  Weather
//
//  Created by  Arthur Bodrov on 17/03/2019.
//  Copyright © 2019  Arthur Bodrov. All rights reserved.
//

import Foundation

let API_URL = "https://api.openweathermap.org/data/2.5/weather?lat=\(Location.sharedIntance.latitude!)&lon=\(Location.sharedIntance.longitude!)&appid=49115142670d56dbd9a5e737ca018e45"

let API_URL_2 = "https://api.openweathermap.org/data/2.5/forecast?lat=\(Location.sharedIntance.latitude!)&lon=\(Location.sharedIntance.longitude!)&appid=49115142670d56dbd9a5e737ca018e45"
typealias DownloadComlpete = () -> ()
