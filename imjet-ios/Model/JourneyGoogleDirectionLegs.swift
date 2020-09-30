//
//  JourneyGoogleDirectionLegs.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 11/16/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class JourneyGoogleDirectionLegs: Object, Mappable {
    @objc dynamic var startAddress: String?
    @objc dynamic var endAddress: String?
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        startAddress <- map["start_address"]
        endAddress <- map["end_address"]
    }
}
