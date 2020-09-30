//
//  Profile.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 9/21/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class Profile: Object, Mappable {
    @objc dynamic var id: Int = 0
    @objc dynamic var name: String?
    @objc dynamic var birthday: String?
    @objc dynamic var phoneNumber: String?
    @objc dynamic var countryCode: String?
    @objc dynamic var email: String?
    @objc dynamic var purpose: String?
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    convenience required init?(map: Map) {
        self.init()
        id <- map["id"]
    }
    
    func mapping(map: Map) {
        name <- map["name"]
        birthday <- map["birthday"]
        phoneNumber <- map["phoneNumber"]
        countryCode <- map["countryCode"]
        email <- map["email"]
        purpose <- map["purpose"]
    }
}

extension Profile {
    
}

