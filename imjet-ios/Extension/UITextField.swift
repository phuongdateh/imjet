//
//  UITextField.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 9/28/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import UIKit

extension UITextField {
    func setFontAndTextColor(fontType: DefaultFontType, size: CGFloat, color: UIColor) {
        self.font = UIFont.init(defaultFontType: fontType, size: size)
        self.textColor = color
    }
}
