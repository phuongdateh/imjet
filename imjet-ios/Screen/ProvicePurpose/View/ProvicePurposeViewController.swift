//
//  ProvicePurposeViewController.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 9/21/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import UIKit

class ProvicePurposeViewController: ViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var userWrapperView: UIView!
    @IBOutlet weak var driverWrapperView: UIView!
    @IBOutlet weak var titlePurposeLb: UILabel!
    
    @IBOutlet weak var iconDriverImageView: UIImageView!
    @IBOutlet weak var titleDriverLb: UILabel!
    
    @IBOutlet weak var iconUserImageView: UIImageView!
    @IBOutlet weak var titleUserLb: UILabel!
    
    // MARK: - Properties
    var listUIView: [UIView] = []
    var presenter: ProvicePurposePresenterProtocol?
    
    // for test
    private let subView: UIView = UIView()
    
    // MARK: - Override
    override class func storyBoardId() -> String {
        return "ProvicePurposeViewController"
    }

    override class func storyBoardName() -> String {
        return "ProvicePurpose"
    }

    // MARK: - View Lyfe cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
////        view.addSubviewForLayout(subView)
//        view.addConstraints([subView.alignTop(to: self.view),
//                            subView.alignLeading(to: self.view),
//                            subView.alignTrailing(to: self.view),
//                            subView.configHeight(250)])
//        let wrapperView = UIView()
//        subView.addSubviewForLayout(wrapperView)
//        subView.addConstraints([
//            wrapperView.relationCenterX(to: subView),
//            wrapperView.relationCenterY(to: subView),
//            wrapperView.configHeight(100),
//            wrapperView.configWidth(100)
//        ])
//        wrapperView.backgroundColor = .red
//
//
//
//
//
//        subView.isUserInteractionEnabled = true
//        wrapperView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(interacView_Tap)))
//        subView.backgroundColor = .green
        
        
        
        
        let attributeStr: NSMutableAttributedString = NSMutableAttributedString.init()
        attributeStr.append(NSAttributedString.init(string: "Tôi là? \n", attributes: [
            NSAttributedStringKey.font: UIFont.init(defaultFontType: .bold, size: 30)!,
            NSAttributedStringKey.foregroundColor: UIColor.init(0x101010)
        ]))
        attributeStr.append(NSAttributedString.init(string: "Chọn 1 trong 2 để thực hiện bước tiếp theo.", attributes: [NSAttributedStringKey.font: UIFont.init(defaultFontType: .regular, size: 14)!, NSAttributedStringKey.foregroundColor: UIColor.init(0x101010)]))
        
        titlePurposeLb.attributedText = attributeStr
    
        listUIView = [userWrapperView, driverWrapperView]
        for view in listUIView {
            view.layer.cornerRadius = 10
            view.addShadow()
        }
        
        iconDriverImageView.setImage(assetId: .iconDriverHome)
        iconUserImageView.setImage(assetId: .iconUserHome)
        driverWrapperView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(driverWrapperView_Tap)))
        userWrapperView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(userWrapperView_Tap)))
        
        if let presenter = presenter {
            presenter.getProfile()
        }
        
        JETLocationManager.sharedInstance.startGettingLocation()
    }
    
    @objc func interacView_Tap() {
        if let vc = LandingWireFrame.createLandingViewController() {
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let navigaitionController = navigationController {
            navigaitionController.setNavigationBarHidden(true, animated: false)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let navigationController = navigationController {
            navigationController.setNavigationBarHidden(false, animated: false)
        }
    }
    // MARK: - UITapGestureRecognizer
    @objc func userWrapperView_Tap() {
        if let presenter = presenter {
//            presenter.pushSearchAddress(JourneyRequestBuilder.init(userPurpose: "user"))
            presenter.pushJourney(with: .enterAddress, JourneyRequestBuilder.init(userPurpose: "user"))
            UserDefaults.standard.setValue("user", forKey: Constants.typeUser)
        }
        
        
    }
    
    @objc func driverWrapperView_Tap() {
        if let presenter = presenter {
            presenter.pushJourney(with: .enterAddress, JourneyRequestBuilder.init(userPurpose: "driver"))
            UserDefaults.standard.setValue("driver", forKey: Constants.typeUser)
        }
    }
}

// MARK: - ProvicePurposeViewProtocol
extension ProvicePurposeViewController: ProvicePurposeViewProtocol {
    func didProvicePurposeSuccess() {
       
    }
    
    func didProvicePurposeFail(_ code: Int) {
    
    }
}
