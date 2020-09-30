//
//  Journey.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 10/20/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

class JourneyRequestBuilder: NSObject, Encodable {
    @objc dynamic var departureTime: Int = 0
    @objc dynamic var userPurpose: String?
    var totalSeats: Int = 1
    var vehicle: String = "bike"
    @objc dynamic var phoneNumber: String?
    @objc dynamic var isPlan: Bool = false
    @objc dynamic var directionRequestID: String?
    
    init (userPurpose: String) {
        self.userPurpose = userPurpose
    }
    
}
