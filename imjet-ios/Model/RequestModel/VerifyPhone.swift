//
//  VerifyCode.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 9/12/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

class VerifyPhone: Encodable {
    var phoneNumber: String
    var countryCode: String = "84"
    
    init(phoneNumber: String) {
        self.phoneNumber = phoneNumber
    }
}

