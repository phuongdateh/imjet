//
//  GoogleRoute.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 10/23/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

class GoogleRoute: Decodable {
    var legs: [GoogleDirectionLegs] = []
    var overviewPolyline: GoogleOverviewPolyline?

    enum CodingKeys: String, CodingKey {
        case legs
        case overviewPolyline = "overview_polyline"
    }
}

