//
//  ConfirmButton.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 4/2/20.
//  Copyright © 2020 DoanDuyPhuong. All rights reserved.
//

import Foundation
import UIKit

protocol ConfirmButtonAction {
    func action()
}

class ConfirmButton: View {
    
    private let wrapperView: UIView = UIView.init()
    private let titleLb: UILabel = UILabel.init()
    private let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView.init()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    convenience init? (frame: CGRect, title: String) {
        self.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func presetupView() {
        addSubview(wrapperView)
        wrapperView.addConstraints([
            alignTop(to: self, space: 15),
            alignLeading(to: self, space: 15),
            alignTrailing(to: self, space: 15),
            alignBottom(to: self, space: 15)])
        wrapperView.backgroundColor = ColorSystem.greenBGOpacity
        
    }
        
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
    
    func startLoading() {
        
    }
    
    func endLoading() {
        
    }
}
