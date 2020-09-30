//
//  JourneyWrapper.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 11/15/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class JourneyWrapper: Object {
    @objc dynamic var id: Int = -1
    @objc dynamic var orderNumber: Int = 0
    @objc dynamic var journey: Journey!
    @objc dynamic var group: String = ""
    @objc dynamic var month: String = ""
    
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    convenience init (json: [String: AnyObject], orderNumber: Int, group: String) {
        self.init()
        let map = Map.init(mappingType: .fromJSON, JSON: json)
        let journey = Journey.init(map: map)!
        journey.mapping(map: map)
        self.orderNumber = orderNumber
        self.journey = journey
        self.id = orderNumber
        self.group = group
        
        if let date = journey.departureTimestamp.asDate() {
            let monthStr = date.asString(format: .month)
            self.month = monthStr
        }
    }
    
}

extension JourneyWrapper {
    class func getCurrentGroup() -> String {
        return "current"
    }
    
    class func getHistoryGroup() -> String {
        return "history"
    }
}

