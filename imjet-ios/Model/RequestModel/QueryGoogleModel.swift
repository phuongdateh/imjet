//
//  QueryGoogleModel.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 10/23/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

class QueryGoogleModel: Encodable {
    var origin: String
    var destination: String
    var waypoints: String?
    
    init(origin: String,_ destination: String) {
        self.origin = origin
        self.destination = destination
    }
}
