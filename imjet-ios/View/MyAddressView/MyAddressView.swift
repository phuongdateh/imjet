//
//  MyAddressView.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 12/8/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import UIKit

protocol MyAddressViewDelegate: class {
    func myAddressViewDelegateDidTapCurrentLocationWrapperView(from view: MyAddressView)
}

class MyAddressView: UIView {
    
    // MARK: - IBOutlets
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLb: UILabel!
    @IBOutlet weak var currentLocationWrapperView: UIView!
    
    // MARK: - Properties
    weak var delegate: MyAddressViewDelegate?
    var isSelected: Bool = false {
        didSet {
            didSetSelected()
        }
    }
    
    // MARK: - NibName
    class func nibName() -> String {
        return "MyAddressView"
    }
    
    // MARK: - Lyfe cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        currentLocationWrapperView.backgroundColor = ColorSystem.white
        currentLocationWrapperView.layer.cornerRadius = 10
        currentLocationWrapperView.addShadow()
        currentLocationWrapperView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(currentLocationWrapperView_DidTap)))
        titleLb.font = FontSystem.normalText
        titleLb.text = "Vị trí hiện tại"
    }
    
    func didSetSelected() {
        if isSelected == false {
            currentLocationWrapperView.backgroundColor = ColorSystem.white
            titleLb.textColor = ColorSystem.black
            iconImageView.setImage(assetId: .currentLocationBlackIcon)
        }
        else {
            currentLocationWrapperView.backgroundColor = ColorSystem.green
            titleLb.textColor = ColorSystem.white
            iconImageView.setImage(assetId: .currentLocationWhiteIcon)
        }
    }
    
    @objc func currentLocationWrapperView_DidTap() {
        isSelected = !isSelected
        if let delegate = delegate {
            delegate.myAddressViewDelegateDidTapCurrentLocationWrapperView(from: self)
        }
    }
}
