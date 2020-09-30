//
//  JourneyCurrent.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 12/26/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class JourneyCurrent: Object {
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
        self.group = group
        self.orderNumber = orderNumber
        if let date = journey.departureTimestamp.asDate() {
            self.month = date.asString(format: .month)
        }
    }
}

extension JourneyCurrent {
    static func getJourneyCurrentList() -> Results<JourneyCurrent> {
        let realm = try! Realm()
        return realm.objects(JourneyCurrent.self).filter("group = %@", JourneyListType.current.rawValue).sorted(byKeyPath: "orderNumber", ascending: true)
    }
}
