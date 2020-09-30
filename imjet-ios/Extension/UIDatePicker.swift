//
//  UIDatePicker.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 12/12/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import UIKit

extension UIDatePicker {
    var textColor: UIColor? {
        set {
            setValue(newValue, forKeyPath: "textColor")
        }
        get {
            return value(forKeyPath: "textColor") as? UIColor
        }
    }

    func hideSelectionsIndicator(isShow: Bool = false) {
        self.subviews[0].subviews[1].isHidden = !isShow
        self.subviews[0].subviews[2].isHidden = !isShow
    }
}
