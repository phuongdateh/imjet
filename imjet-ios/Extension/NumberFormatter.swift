//
//  NumberFormatter.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 11/23/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

extension NumberFormatter {
    static let currencyInput: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = Locale.init(identifier: "vi_VN")
        formatter.numberStyle = .currency
        formatter.currencySymbol = ""
        formatter.maximumFractionDigits = 0
        formatter.minimumFractionDigits = 0
        return formatter
    }()
    
    static let currencyForrmater: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.locale = Locale.init(identifier: "vi_VN")
        formatter.numberStyle = .currency
        formatter.currencySymbol = ""
        formatter.maximumFractionDigits = 0
        formatter.minimumFractionDigits = 0
        return formatter
    }()
}
