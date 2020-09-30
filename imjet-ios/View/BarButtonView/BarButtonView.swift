//
//  BarButtonView.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 8/28/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import UIKit

enum BarButtonViewStyle {
    case left
    case right
}

protocol BarButtonViewDelegate: class {
    func barButtonViewDidTap(_ view: BarButtonView)
}

class BarButtonView: UIView {
    
    @IBOutlet weak var iconImageView: UIImageView!
    
    @IBOutlet weak var iconImageViewTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var iconImageViewLeadingConstraint: NSLayoutConstraint!
    
    weak var delegate: BarButtonViewDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        iconImageView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(iconImageView_Tap)))
    }
    
    @objc func iconImageView_Tap() {
        if let delegate = delegate {
            delegate.barButtonViewDidTap(self)
        }
    }
    
    func setTintColor(_ color: UIColor) {
        if color != iconImageView.tintColor {
            iconImageView.tintColor = color
        }
    }
    
    func setStyle(style: BarButtonViewStyle) {
        switch style {
        case .left:
            iconImageViewLeadingConstraint.constant = 0
            iconImageViewTrailingConstraint.constant = 24
        case .right:
            iconImageViewLeadingConstraint.constant = 24
            iconImageViewTrailingConstraint.constant = 0
        }
    }
    
    class func nibName() -> String {
        return "BarButtonView"
    }
    
}
