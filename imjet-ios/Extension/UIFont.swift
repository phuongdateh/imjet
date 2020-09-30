//
//  UIFont.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 9/27/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import UIKit

enum DefaultFontType: String {
    case black = "Black"
    case blackItalic = "BlackItalic"
    case bold = "Bold"
    case boldItalic = "BoldItalic"
    case italic = "Italic"
    case light = "Light"
    case lightItalic = "LightItatlic"
    case medium = "Medium"
    case mediumItalic = "MediumItalic"
    case regular = "Regular"
    case thin = "Thin"
    case thinItalic = "ThinItalic"
}

enum TitleFontType: String {
    case bold = "Bold"
    case medium = "Medium"
    case regular = "Regular"
}

extension UIFont {
    convenience init?(defaultFontType: DefaultFontType, size: CGFloat) {
        self.init(name: "Roboto-" + defaultFontType.rawValue, size: size)
    }
    
    convenience init?(titleFont: TitleFontType, size: CGFloat) {
        self.init(name: "Montserrat-" + titleFont.rawValue, size: size)
    }
}
