//
//  ActivityIndicatorView.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 4/6/20.
//  Copyright © 2020 DoanDuyPhuong. All rights reserved.
//

import Foundation
import UIKit

class ActivityIndicatorView: UIView {
    
    // shareInstance
    static let sharedInstance: ActivityIndicatorView = {
         return ActivityIndicatorView.init(frame: CGRect.init(x: 0, y: 0, width: ViewService.screenSize().width, height: ViewService.screenSize().height))
    }()
    
    private let loadingIndicator: UIActivityIndicatorView = UIActivityIndicatorView.init()
    private let loadingIndicatorWrapperView: UIView = UIView()
    
    var isLoading: Bool = false
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setupView() {
        self.frame.size = ViewService.screenSize()
        self.frame.origin = CGPoint.init(x: 0, y: 0)
        self.addSubviewForLayout(loadingIndicatorWrapperView)
        self.addConstraints([loadingIndicatorWrapperView.relationCenterX(to: self),
                             loadingIndicatorWrapperView.relationCenterY(to: self)])
        loadingIndicatorWrapperView.addConstraints([loadingIndicatorWrapperView.configWidth(60), loadingIndicatorWrapperView.configHeight(60)])
        loadingIndicatorWrapperView.backgroundColor = UIColor.init(0x000000, alpha: 60)
        loadingIndicatorWrapperView.alpha = 0.6
        loadingIndicatorWrapperView.layer.cornerRadius = 10
        loadingIndicatorWrapperView.layer.masksToBounds = true
        loadingIndicatorWrapperView.addChildView(loadingIndicator, top: 20, bottom: 20, trailing: 20, leading: 20)
        loadingIndicator.addConstraints([loadingIndicator.configWidth(37),
                                           loadingIndicator.configHeight(37)])
        loadingIndicator.startAnimating()
        loadingIndicator.color = .white
        loadingIndicator.hidesWhenStopped = true
        let transform = CGAffineTransform.init(scaleX: 1.5, y: 1.5)
        loadingIndicator.transform = transform
    }
    
    func beginLoading() {
        if let window = UIApplication.shared.keyWindow, isLoading == false {
            self.isHidden = false
            window.addSubview(self)
            window.bringSubview(toFront: self)
            isLoading = true
        }
    }
    
    func endLoading() {
        if let _ = superview, isLoading {
            self.isHidden = true
            removeFromSuperview()
            isLoading = false
        }
    }
}
