//
//  GoogleAddressComponent.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 10/15/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

class GoogleAddressComponent: Decodable {
    var longName: String = ""
    var shortName: String = ""
    var types: [String] = []
    
    enum CodingKeys: String, CodingKey {
        case longName = "long_name"
        case shortName = "short_name"
        case types
    }
}
