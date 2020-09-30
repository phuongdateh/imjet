//
//  Rating.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 1/2/20.
//  Copyright © 2020 DoanDuyPhuong. All rights reserved.
//

import Foundation

class Rating: Encodable {
    var partnerJourneyID: Int?
    var point: Int = 1
    var content: String = ""
    
    init(partnerJourneyID: Int) {
        self.partnerJourneyID = partnerJourneyID
    }
}
