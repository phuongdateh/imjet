//
//  ResponseData.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 8/24/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

class ResponseData {
    var code: Int?
    var value: Any?
    var url: String?
    
    init(code: Int, value: Any, url: String) {
        self.code = code
        self.value = value
        self.url = url
    }
}
