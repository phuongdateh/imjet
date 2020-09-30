//
//  UserLogin.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 9/19/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

class UserLogin: Encodable {
    var phoneNumber: String
    var password: String
    var countryCode: String = "84"

    init(phoneNumber: String, password: String) {
        self.phoneNumber = phoneNumber
        self.password = password
    }
}
