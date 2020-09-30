//
//  UIColor.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 11/21/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {
    /// Initializes UIColor with an integer.
    ///
    /// - parameter value: The integer value of the color. E.g. 0xFF0000 is red, 0x0000FF is blue.
    public convenience init(_ value: Int) {
        let components = getColorComponents(value)
        self.init(red: components.red, green: components.green, blue: components.blue, alpha: 1.0)
    }
    
    /// Initializes UIColor with an integer and alpha value.
    ///
    /// - parameter value: The integer value of the color. E.g. 0xFF0000 is red, 0x0000FF is blue.
    /// - parameter alpha: The alpha value.
    public convenience init(_ value: Int, alpha: CGFloat) {
        let components = getColorComponents(value)
        self.init(red: components.red, green: components.green, blue: components.blue, alpha: alpha)
    }
}

private func getColorComponents(_ value: Int) -> (red: CGFloat, green: CGFloat, blue: CGFloat) {
    let r = CGFloat(value >> 16 & 0xFF) / 255.0
    let g = CGFloat(value >> 8 & 0xFF) / 255.0
    let b = CGFloat(value & 0xFF) / 255.0
    
    return (r, g, b)
}
