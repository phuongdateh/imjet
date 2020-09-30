//
//  User.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 12/29/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class User: Object, Mappable {
    @objc dynamic var id: Int = -1
    @objc dynamic var name: String?
    @objc dynamic var phoneNumber: String?
    @objc dynamic var countryCode: String?
    @objc dynamic var email: String?
    @objc dynamic var gender: String?
    @objc dynamic var purpose: String?
    @objc dynamic var birthday: String?
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    convenience required init?(map: Map) {
        self.init()
        id <- map["id"]
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        phoneNumber <- map["phoneNumber"]
        countryCode <- map["countryCode"]
        email <- map["email"]
        purpose <- map["purpose"]
        birthday <- map["birthday"]
        gender <- map["gender"]
    }
}

extension User {
    class func currentUser() -> User? {
        if let currentUserId = UserDefaults.standard.object(forKey: Constants.currentUserId) as? Int {
            let realm = try! Realm()
            return realm.object(ofType: User.self, forPrimaryKey: currentUserId)
        }
        return nil
    }
}
