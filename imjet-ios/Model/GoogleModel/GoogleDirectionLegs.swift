//
//  GoogleDirectionLegs.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 10/30/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

class GoogleDirectionLegs: Decodable {
    var distance: GoogleDirectionLegDistance = GoogleDirectionLegDistance()
    var startLocation: GoogleDirectionLegLocation?
    var endLocation: GoogleDirectionLegLocation?
    
    enum CodingKeys: String, CodingKey {
        case distance
        case startLocation = "start_location"
        case endLocation = "end_location"
    }
}
