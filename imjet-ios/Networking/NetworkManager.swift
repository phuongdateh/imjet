//
//  NetworkManager.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 8/24/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

typealias NetworkCompletionHandler = (_ error: ErrorData?,_ response: ResponseData?) -> ()

enum RequestTaskType {
    case get
    case put
    case post
    case delete
}

enum DataType {
    case image
    case string
    case data
}

class NetworkManager {
    var wrapper: NetworkWrapper
    init() {
        wrapper = AlamofireAPIWrapper()
    }
}
