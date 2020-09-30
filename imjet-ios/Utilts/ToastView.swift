//
//  ToastView.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 9/17/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import UIKit

class ToastView: UIView {
    static let sharedInstance: ToastView = {
        let view = ToastView.init(frame: CGRect.init(x: 10, y: -30, width: 0, height: 0))
        return view
    }()
    private let contentLbl: UILabel = UILabel.init()
    private var lastTimeUpdateContent: Date?
    override init(frame: CGRect) {
        super.init(frame: frame)
        isUserInteractionEnabled = false
        addShadow()
        backgroundColor = UIColor.black.withAlphaComponent(0.6)
        layer.cornerRadius = 10
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func setBackgroundColor(color: UIColor) {
        backgroundColor = color
    }
    
    func showContent(_ text: String) {
        if superview == nil {
            let window = UIApplication.shared.keyWindow!
            window.addSubview(self)
        }
        
        alpha = 1
        if contentLbl.superview != nil {
            
        }
        else {
            addSubview(contentLbl)
        }
        contentLbl.numberOfLines = 0
        contentLbl.text = text
        contentLbl.textColor = UIColor.white
        contentLbl.font = UIFont.init(name: "Helvetica Neue", size: 14)
        contentLbl.numberOfLines = 0
        contentLbl.frame.origin = CGPoint.init(x: 15, y: 15)
        let calculatedContentLblWidth = contentLbl.widthOfLabel()
        if calculatedContentLblWidth > ViewService.screenSize().width - 50 {
            frame.size.width = ViewService.screenSize().width - 50
        }
        else {
            frame.size.width = calculatedContentLblWidth
        }
        contentLbl.frame.size.width = calculatedContentLblWidth
        contentLbl.frame.size.height = contentLbl.heightOfLabel()
        frame.size.width = calculatedContentLblWidth + 30
        frame.size.height = contentLbl.frame.height + 30
        let y = ViewService.screenSize().height - frame.height - 120
        let x: CGFloat = (ViewService.screenSize().width - frame.width)/2
        frame.origin = CGPoint.init(x: x, y: y)
        lastTimeUpdateContent = Date()
        let oldLastTimeUpdateContent = lastTimeUpdateContent
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) { [weak self] in
            if let weakSelf = self, oldLastTimeUpdateContent == weakSelf.lastTimeUpdateContent {
                UIView.animate(withDuration: 0.3, animations: {[weak self] in
                    if let weakSelf = self {
                        weakSelf.alpha = 0
                    }
                    }, completion: {[weak self](isCompleted) in
                        if isCompleted == true {
                            if let weakSelf = self {
                                weakSelf.removeFromSuperview()
                            }
                        }
                        
                })
            }
        }
    }
}
