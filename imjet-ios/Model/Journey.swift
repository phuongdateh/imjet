//
//  Journey.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 11/1/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class Journey: Object, Mappable {
    @objc dynamic var id: Int = -1
    @objc dynamic var userPurpose: String?
    @objc dynamic var departureTime: String?
    @objc dynamic var departureTimestamp: Int = 0
    @objc dynamic var arrivalTimestamp: Int = 0
    @objc dynamic var vehicle: String?
    @objc dynamic var status: String?
    @objc dynamic var totalFee: Float = 0
    @objc dynamic var isPlan: Bool = false
    @objc dynamic var phoneNumber: String?
    @objc dynamic var googleDirection: JourneyGoogleDirection?
    let partners: List<Journey>! = List<Journey>()
    @objc dynamic var createdBy: User?
    
    override class func primaryKey() -> String? {
        return "id"
    }
    
    convenience required init?(map: Map) {
        self.init()
        id <- map["id"]
    }
    
    func mapping(map: Map) {
        userPurpose <- map["userPurpose"]
        departureTime <- map["departureTime"]
        departureTimestamp <- map["departureTimestamp"]
        arrivalTimestamp <- map["arrivalTimestamp"]
        vehicle <- map["vehicle"]
        status <- map["status"]
        totalFee <- map["totalFee"]
        isPlan <- map["isPlan"]
        phoneNumber <- map["phoneNumber"]
        googleDirection <- map["googleDirection"]
        if let jsonDict = map.JSON["partners"] as? [[String: AnyObject]] {
            for json in jsonDict {
                let map = Map.init(mappingType: .fromJSON, JSON: json)
                if let journey = Journey.init(map: map) {
                    journey.mapping(map: map)
                    partners.append(journey)
                }
            }
        }
        createdBy <- map["createdBy"]
    }
}

extension Journey {
    func getDestinationAddress() -> String? {
        if let googleDirection = googleDirection {
            if let routeList = googleDirection.routesList, routeList.count > 0 {
                let route = routeList[0]
                if let legs = route.legs {
                    let leg = legs[0]
                    return leg.endAddress
                }
            }
        }
        return ""
    }
    
    func getSourceAddress() -> String? {
        if let googleDirection = googleDirection {
            if let routeList = googleDirection.routesList, routeList.count > 0 {
                let route = routeList[0]
                if let legs = route.legs {
                    let leg = legs[0]
                    return leg.startAddress
                }
            }
        }
        return ""
    }
    
    func getUsernamePartner() -> String {
        if partners.count > 0 {
            let partner = partners[0]
            if let user = partner.createdBy,
                user.isInvalidated == false {
                if let name = user.name {
                    return name
                }
            }
        }
        return ""
    }
    
    func getUsername() -> String {
        if let createdBy = createdBy {
            if let name = createdBy.name {
                return name
            }
        }
        return ""
    }
    
    func getPartnerId() -> Int {
        if partners.count > 0 {
            let partner = partners[0]
            return partner.id
        }
        return 0
    }
    
}
