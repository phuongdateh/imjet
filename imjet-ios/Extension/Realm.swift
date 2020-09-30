//
//  Realm\.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 9/23/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import RealmSwift

extension Realm {
    public func safeWrite(_ block: (() throws -> Void)) {
        if isInWriteTransaction == true {
            try! block()
        } else {
            try! write(block)
        }
    }
}
