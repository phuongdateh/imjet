//
//  UIImage.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 9/30/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import UIKit

public extension UIImageView {
    func setImage(assetId: AssetIdentifier) {
        self.image = UIImage.init(assetId: assetId)
    }
}
