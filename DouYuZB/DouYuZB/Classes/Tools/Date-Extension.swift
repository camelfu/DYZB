//
//  Date-Extension.swift
//  DouYuZB
//
//  Created by Camel on 2020/12/15.
//

import UIKit
extension Date {
    static func getCurrentTimeSamp() -> String{
        let nowDate = Date()
        let interval: Int = Int(nowDate.timeIntervalSince1970)
        print("\(interval)")
        return "\(interval)"
    }
}
