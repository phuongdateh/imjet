//
//  Int.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 11/16/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

extension Int {
    func asDate() -> Date? {
        return Date.init(timeIntervalSince1970: TimeInterval(self))
    }
}
