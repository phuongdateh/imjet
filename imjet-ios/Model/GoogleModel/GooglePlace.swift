//
//  GooglePlace.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 10/18/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

class GooglePlace: Decodable {
    var description: String?
    var placeId: String?
    var structuredFormatting: GoogleStructuredFormatting?
    
    enum CodingKeys: String, CodingKey {
        case description = "description"
        case placeId = "place_id"
        case structuredFormatting = "structured_formatting"
    }
}
