//
//  NetworkManagerUtilities.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 9/8/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import UIKit

final class NetworkManagerUtilities {
    class func convertalue(value: Any) -> Any? {
        if let value = value as? [[String: AnyObject]] {
            return value
        }
        if let value = value as? [String: AnyObject] {
            return value
        }
        if let value = value as? String {
            if let data = value.data(using: String.Encoding.utf8) {
                do {
                    return try JSONSerialization.jsonObject(with: data, options: [])
                }
                catch {
                    return ("Error in convert value: \(error.localizedDescription)")
                }
            }
        }
        return nil
    }
    
    class func responseDataAndCodeFrom(destiantionURL: URL, code: Int, dataType: DataType, requestURL: URL, completionHandler: @escaping NetworkCompletionHandler) {
        switch dataType {
        case .data:
            do {
                let data = try Data.init(contentsOf: destiantionURL, options: Data.ReadingOptions.init(rawValue: 8))
                let responseData = ResponseData.init(code: code, value: data, url: requestURL.absoluteString)
                completionHandler(nil, responseData)
                return
            }
            catch {
                
            }
        case .image:
            if let image = UIImage.init(contentsOfFile: destiantionURL.absoluteString) {
                let responseData = ResponseData.init(code: code, value: image, url: requestURL.absoluteString)
                completionHandler(nil, responseData)
                return
            }
        case .string:
            do {
                let string = try String.init(contentsOfFile: destiantionURL.absoluteString)
                let responseData = ResponseData.init(code: code, value: string, url: requestURL.absoluteString)
                completionHandler(nil, responseData)
                return
            }
            catch {
            
            }
        }
        let errorData = ErrorData.init(code: 9999, value: "Somethings went wrong")
        completionHandler(errorData, nil)
        return
    }
}
