//
//  GlobalFeeRequest.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 10/29/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

class GlobalFeeRequest: Encodable {
    var vehicle: String = "bike"
    var totalSeats: Int = 1
    var distance: Int = 0
    
    init(distance: Int) {
        self.distance = distance
    }
}
