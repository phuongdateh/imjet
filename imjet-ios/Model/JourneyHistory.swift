//
//  JourneyHistory.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 12/26/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

enum JourneyListType: String {
    case history = "history"
    case current = "current"
}

class JourneyHistory: Object {
    @objc dynamic var id: String = ""
    @objc dynamic var orderNumber: Int = 0
    @objc dynamic var group: String = ""
    @objc dynamic var journey: Journey?
    @objc dynamic var month: String = ""
    
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    convenience init (journey: Journey, group: String, orderNumber: Int) {
        self.init()
        self.id = "\(group)-\(journey.id)"
        self.journey = journey
        self.orderNumber = orderNumber
        self.group = group
        if let date = journey.departureTimestamp.asDate() {
            self.month = date.asString(format: .month)
        }
    }
    
//    convenience init (json: [String: AnyObject], orderNumber: Int) {
//        self.init()
//        let map = Map.init(mappingType: .fromJSON, JSON: json)
//        let journey = Journey.init(map: map)!
//        journey.mapping(map: map)
//        self.orderNumber = orderNumber
//        self.journey = journey
//        self.id = orderNumber
//
//        if let date = journey.departureTimestamp.asDate() {
//            let monthStr = date.asString(format: .month)
//            self.month = monthStr
//        }
//    }
}

extension JourneyHistory {
    static func getJourneyHistoryList() -> Results<JourneyHistory> {
        let realm = try! Realm()
        return realm.objects(JourneyHistory.self).filter("group = %@", JourneyListType.history.rawValue).sorted(byKeyPath: "orderNumber", ascending: true)
    }
}
