//
//  Dictionnary.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 10/16/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

extension Dictionary {
    var data: Data? {
        get {
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: self, options: .prettyPrinted)
                return jsonData
            }
            catch {
                return nil
            }
        }
    }
}
