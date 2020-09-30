//
//  NotificationFCM.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 10/13/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import UIKit

class NotificationFCM: Encodable {
    var registrationToken: String
    var device: String
    var deviceID: String?
    var osVersion: String?
    var imei: String?
    
    init(_ registrationToken: String) {
        self.registrationToken = registrationToken
        self.device = UIDevice.current.modelName
        if let identifierForVendor = UIDevice.current.identifierForVendor {
            self.deviceID = identifierForVendor.uuidString
        }
        self.osVersion = UIDevice.current.systemVersion
        self.imei = ""
    }
}
