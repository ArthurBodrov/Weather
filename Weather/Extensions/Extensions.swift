//
//  Extensions.swift
//  Weather
//
//  Created by  Arthur Bodrov on 17/03/2019.
//  Copyright © 2019  Arthur Bodrov. All rights reserved.
//

import Foundation


extension Double {
    func rounded(toPlaces places: Int) -> Double{
        let divisor = pow(10.0, Double(places))
        return (self * divisor).rounded() / divisor
    }
}

extension Date {
    func hourAndMinute() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "hha"
        return dateFormatter.string(from: self)
    }
}
