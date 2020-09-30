//
//  PopupHelmetViewController.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 12/10/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import UIKit

protocol PopupHelmetViewControllerDelegate: class {
    func popupHelmetViewControllerDidTapConfirmHelmet(from viewController: PopupHelmetViewController, isHelmet: Bool)
}

class PopupHelmetViewController: ViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var cancelWrapperView: UIView!
    
    @IBOutlet weak var contentWrapperView: UIView!
    @IBOutlet weak var titleLb: UILabel!
    
    @IBOutlet weak var yesHelmetWrapperView: UIView!
    @IBOutlet weak var yesTitleLb: UILabel!
    @IBOutlet weak var yesIconWrapperView: UIView!
    
    @IBOutlet weak var noHelmetWrapperView: UIView!
    @IBOutlet weak var noTitleLb: UILabel!
    @IBOutlet weak var noIconWrapperView: UIView!
    
    @IBOutlet weak var confirmButton: UIButton!
    
    // MARK: - Properties
    weak var delegate: PopupHelmetViewControllerDelegate?
    private var isHelmet: Bool! {
        didSet {
            updateView()
        }
    }
    var builder: JourneyRequestBuilder?
    private var purposeBGColor: UIColor = UIColor.init()
    
    // MARK: - MetaData
    override class func storyBoardId() -> String {
        return "PopupHelmetViewController"
    }
    
    override class func storyBoardName() -> String {
        return "PopupHelmet"
    }
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        if let builder = builder {
//            if let purpose = builder.userPurpose {
//                if purpose == "user" {
//                    purposeBGColor = ColorSystem.black
//                }
//                else {
//                    purposeBGColor = ColorSystem.green
//                }
//            }
//        }
        purposeBGColor = ColorSystem.currentPurposeColor()
        
        titleLb.text = "popup.helmet.title".localized
        titleLb.textColor = ColorSystem.blackOpacity
        titleLb.font = FontSystem.sectionTitle
        
        yesTitleLb.text = "popup.yes.title".localized
        yesTitleLb.textColor = ColorSystem.black
        yesTitleLb.font = FontSystem.normalText
        yesIconWrapperView.layer.cornerRadius = 12
        yesHelmetWrapperView.layer.borderWidth = 1
        yesHelmetWrapperView.layer.cornerRadius = 10
        yesHelmetWrapperView.layer.borderColor = ColorSystem.blackOpacity.cgColor
        yesIconWrapperView.alpha = 0
        yesHelmetWrapperView.backgroundColor = ColorSystem.white
        yesHelmetWrapperView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(yesHelmetWrapperView_DidTap)))
        
        noTitleLb.text = "popup.no.title".localized
        noTitleLb.textColor = ColorSystem.black
        noTitleLb.font = FontSystem.normalText
        noIconWrapperView.layer.cornerRadius = 12
        noHelmetWrapperView.layer.borderWidth = 1
        noHelmetWrapperView.layer.cornerRadius = 10
        noIconWrapperView.alpha = 0
        noHelmetWrapperView.layer.borderColor = ColorSystem.blackOpacity.cgColor
        noHelmetWrapperView.backgroundColor = ColorSystem.white
        noHelmetWrapperView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(noHelmetWrapperView_DidTap)))
        
        confirmButton.layer.cornerRadius = 10
        confirmButton.setTitle("popup.confirm.title".localized, for: .normal)
        confirmButton.titleLabel!.font = FontSystem.buttonTitle
        confirmButton.titleLabel!.textColor = ColorSystem.white
        confirmButton.backgroundColor = purposeBGColor
        
        contentWrapperView.layer.cornerRadius = 10
        contentWrapperView.addShadow()
        cancelWrapperView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(cancelWrapperView_DidTap)))
        
//        updateView()
    }
    
    func updateView() {
        if isHelmet == true {
            yesHelmetWrapperView.layer.borderColor = ColorSystem.green.cgColor
            yesIconWrapperView.backgroundColor = ColorSystem.green
            yesHelmetWrapperView.backgroundColor = ColorSystem.greenBGOpacity
            yesIconWrapperView.alpha = 1
            
            noHelmetWrapperView.layer.borderColor = ColorSystem.blackOpacity.cgColor
            noHelmetWrapperView.backgroundColor = ColorSystem.white
            noIconWrapperView.backgroundColor = ColorSystem.white
            noIconWrapperView.alpha = 0
        }
        else {
            yesHelmetWrapperView.layer.borderColor = ColorSystem.blackOpacity.cgColor
            yesHelmetWrapperView.backgroundColor = ColorSystem.white
            yesIconWrapperView.backgroundColor = ColorSystem.white
            yesIconWrapperView.alpha = 0
            
            noHelmetWrapperView.layer.borderColor = ColorSystem.green.cgColor
            noHelmetWrapperView.backgroundColor = ColorSystem.greenBGOpacity
            noIconWrapperView.backgroundColor = ColorSystem.green
            noIconWrapperView.alpha = 1
        }
    }
    
    @objc func cancelWrapperView_DidTap() {
        dismiss(animated: true, completion: nil)
    }
    
    @objc func yesHelmetWrapperView_DidTap() {
        isHelmet = true
    }
    
    @objc func noHelmetWrapperView_DidTap() {
        isHelmet = false
    }

    @IBAction func confirmButton_touchUpInside(_ sender: Any) {
        if isHelmet == nil {
//            ToastView.sharedInstance.showContent("Bạn có mũ bảo hiểm không ạ?")
        }
        else {
            if let delegate = delegate {
                delegate.popupHelmetViewControllerDidTapConfirmHelmet(from: self, isHelmet: isHelmet)
            }
            dismiss(animated: true, completion: nil)
        }
    }
}
