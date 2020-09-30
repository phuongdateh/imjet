//
//  Date.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 11/16/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

enum DateFormaterString: String {
    case dayMonthYear = "dd/MM/yyyy"
    case hourDayMonthYear = "HH:mm, EEEE dd.MM.yyyy"
    case month = "MM"
    case dayofweek = "EEEE"
    case day = "dd"
    case hour = "HH"
    case minute = "mm"
    case year = "yyyy"
}

extension Date {
    func asString(format: DateFormaterString) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = .init(identifier: "vi_VN")
        dateFormatter.dateFormat = format.rawValue
        return dateFormatter.string(from: self)
    }
}
