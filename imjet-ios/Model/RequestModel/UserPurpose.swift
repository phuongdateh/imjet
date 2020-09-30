//
//  UserPurpose.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 9/21/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

enum PurposeType: String {
    case helmetUser = "helmet_user"
    case helmetDriver = "helmet_driver"
    case nonHelmetUser = "non_helmet_user"
    case nonHelmetDriver = "non_helmet_driver"
    case none
}

class UserPurpose: Encodable {
    var purpose: String
    
    init(purpose: PurposeType) {
        self.purpose = purpose.rawValue
    }
}
