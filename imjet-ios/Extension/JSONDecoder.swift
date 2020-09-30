//
//  JSONDecoder.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 10/16/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

extension JSONDecoder {
    func map<T: Decodable>(_ type: T.Type, from dict: [String: Any]) -> T? {
        if let data = dict.data {
            do {
                let object = try decode(T.self, from: data)
                return object
            }
            catch {
                return nil
            }
        }
        return nil
    }
}
