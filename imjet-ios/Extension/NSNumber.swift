//
//  NSNumber.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 11/23/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

extension NSNumber {
    func asCurrencyString() -> String? {
        let formatter = NumberFormatter.currencyForrmater
        if let str = formatter.string(from: self) {
            return "\(str) VND"
        }
        else {
            return nil
        }
    }
}
