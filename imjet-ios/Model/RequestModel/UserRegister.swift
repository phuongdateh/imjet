//
//  User.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 9/7/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

class UserRegister: Encodable {
    var countryCode: String = "84"
    var phoneNumber: String
    var password: String
    var name: String
    
    init(phoneNumber: String, password: String, name: String) {
        self.phoneNumber = phoneNumber
        self.password = password
        self.name = name
    }
}
