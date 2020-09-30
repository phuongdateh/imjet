//
//  NetworkSessionManager.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 8/24/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

class NetworkSessionManager {
    var session: AnyObject!
    
    init() {
        session = createSession()
    }
    
    func createSession() -> AnyObject {
        return "Not Implemented" as AnyObject
    }
    
    func currentHeaderForRequest() -> [String: String] {
        let header: [String: String] = [:]
        
        return header
    }
    
    func createParameters(_ paramesters: [String: AnyObject]? ) -> [String: AnyObject] {
        var newParameters: [String: AnyObject] = [:]
        if let paramesters = paramesters {
            let keys = paramesters.keys
            for key in keys {
                newParameters.updateValue(paramesters[key]!, forKey: key)
            }
        }
        return newParameters
    }
}
