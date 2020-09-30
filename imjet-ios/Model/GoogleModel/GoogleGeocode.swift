//
//  GoogleGeocode.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 10/15/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

class GoogleGeocode: Decodable {
    var formattedAddress: String?
    var addressComponents: [GoogleAddressComponent] = []
    var geometry: GoogleGeometry?
    
    enum CodingKeys: String, CodingKey {
        case formattedAddress = "formatted_address"
        case addressComponents = "address_components"
    }
}
