//
//  EditProfileModel.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 9/21/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

class EditProfileModel: Encodable {
    var name: String
    var gender: String?
    var birthday: String?
    var email: String?
    
    init(_ name: String) {
        self.name = name
    }
}
