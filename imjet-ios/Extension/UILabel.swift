//
//  UILabel.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 9/17/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    func heightOfLabel() -> CGFloat {
        let textSize = CGSize.init(width: frame.size.width, height: CGFloat(MAXFLOAT))
        return sizeThatFits(textSize).height
    }
    
    func widthOfLabel() -> CGFloat {
        let textSize = CGSize.init(width: CGFloat(MAXFLOAT), height: frame.size.width)
        return sizeThatFits(textSize).width
    }
    
    func setFontAndTextColor(fontType: DefaultFontType, size: CGFloat, color: UIColor) {
        self.font = UIFont.init(defaultFontType: fontType, size: size)
        self.textColor = color
    }
}
