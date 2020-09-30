//
//  GoogleDirection.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 10/26/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class GoogleDirection: Decodable {
    var routes: [GoogleRoute] = []
    var directionRequestId: String?

    enum CodingKeys: String, CodingKey {
        case routes = "routes"
        case directionRequestId = "requestID"
    }
}
