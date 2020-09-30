    //
//  JourneyGoogleDirection.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 11/16/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class JourneyGoogleDirection: Object, Mappable {
    let routesList: List<JourneyGoogleDirectionRoutes>! = List<JourneyGoogleDirectionRoutes>()
    
    convenience required init?(map: Map) {
        self.init()
    }
    
    func mapping(map: Map) {
        if let jsonDict = map.JSON["routes"] as? [[String: AnyObject]] {
            for json in jsonDict {
                let map = Map.init(mappingType: .fromJSON, JSON: json)
                if let route = JourneyGoogleDirectionRoutes.init(map: map) {
                    route.mapping(map: map)
                    routesList.append(route)
                }
            }
        }
    }
}
