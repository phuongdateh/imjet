//
//  GoogleStructureFormatting.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 10/18/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

class GoogleStructuredFormatting: Decodable {
    var mainText: String?
    var secondaryText: String?
    
    enum CodingKeys: String, CodingKey {
        case mainText = "main_text"
        case secondaryText = "secondary_text"
    }
}



