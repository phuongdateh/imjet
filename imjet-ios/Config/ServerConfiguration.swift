//
//  ServerConfiguration.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 8/23/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

//enum PortService: String {
//    case googleApi = "maps.imjet.vn"
//    case auth = "auth.imjet.vn"
//    case core = "core.imjet.vn"
//}

enum PortService: String {
    case googleApi = "9000/"
    case auth = "9003/"
    case core = "9002/"
}

// Here define config server development and production
class ServerConfiguration: NSObject {
    

//    private let developmentBaseRequestURL: String = "http://dev-"
//    private let productionBaseRequestURL: String = "http://prod-"
    
    private let developmentBaseRequestURL: String = "http://PhuongLoziii.local:"
    private let productionBaseRequestURL: String = "http://prod-"

    
    var baseRequestURL: String = ""
    var uploadImageURL: String = ""
    
    override init() {
        #if DEBUG
        baseRequestURL = developmentBaseRequestURL
//        baseRequestURL = productionBaseRequestURL
        #else
            baseRequestURL = developmentBaseRequestURL
        #endif
    }
}
