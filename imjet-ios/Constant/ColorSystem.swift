//
//  ColorSystem.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 8/23/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import UIKit

struct ColorSystem {
    /// Black , 101010
    static let black: UIColor = UIColor.init(0x101010)
    /// Black Opacity 50% 101010
    static let blackOpacity: UIColor = UIColor.init(0x101010, alpha: 0.5)
    /// Light Gray, E3E3E3
    static let lightGray: UIColor = UIColor.init(0xE3E3E3)
    /// Red , C90000
    static let red: UIColor = UIColor.init(0xC90000)
    /// Yellow, FFCA00
    static let yellow: UIColor = UIColor.init(0xFFCA00)
    /// Green, 00918E
    static let green: UIColor = UIColor.init(0x00918E)
    /// GreenOpacity, 00918E
    static let greenOpacity: UIColor = UIColor.init(0x00918E)
    /// White, FFFFFF
    static let white: UIColor = UIColor.init(0xFFFFFF)
    /// Green Opacity, E8F3F3
    static let greenBGOpacity: UIColor = UIColor.init(0xE8F3F3)
}

extension ColorSystem {
    static func currentPurposeColor() -> UIColor {
        if let currentTypeUser = UserDefaults.standard.object(forKey: Constants.typeUser) as? String {
            if currentTypeUser == "user" {
                return ColorSystem.black
            }
            else {
                return ColorSystem.green
            }
        }
        return UIColor.init(0xE8F3F3) //
    }
}


