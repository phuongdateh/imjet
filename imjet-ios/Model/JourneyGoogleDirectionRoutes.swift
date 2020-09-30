//
//  JourneyGoogleDirectionRoutes.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 11/16/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class JourneyGoogleDirectionRoutes: Object, Mappable {
    let legs: List<JourneyGoogleDirectionLegs>! = List<JourneyGoogleDirectionLegs>()
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        if let legsDict = map.JSON["legs"] as? [[String: AnyObject]] {
            for leg in legsDict {
                let map = Map.init(mappingType: .fromJSON, JSON: leg)
                if let leg = JourneyGoogleDirectionLegs.init(map: map) {
                    leg.mapping(map: map)
                    legs.append(leg)
                }
            }
        }
    }
}
