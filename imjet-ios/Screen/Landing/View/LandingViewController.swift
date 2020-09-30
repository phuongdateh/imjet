//
//  LandingViewController.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 4/3/20.
//  Copyright © 2020 DoanDuyPhuong. All rights reserved.
//

import Foundation
import UIKit

class LandingViewConroller: ViewController {
    
    private var scrollView = UIScrollView()
    private var contentView = UIView()
    private var titleLandingLb = UILabel()
    private var driverWrapperView = UIView()
    private var drirerAvatarImageView = UIImageView()
    private var driverTitleLb = UILabel()
    private var userWrapperView = UIView()
    private var userAvatarImageView = UIImageView()
    private var userTitleLb = UILabel()
    
    
    // MARK: - viewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        if let navigationController = navigationController {
//            navigationController.setNavigationBarHidden(true, animated: false)
//        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if let navigationController = navigationController {
            navigationController.setNavigationBarHidden(false, animated: false)
        }
    }
    
    func setupView() {
        view.backgroundColor = ColorSystem.white
        scrollView.backgroundColor = ColorSystem.white
        scrollView.isScrollEnabled = false
        contentView.backgroundColor = ColorSystem.white
        view.addChildView(scrollView)
        scrollView.addChildView(contentView)
        scrollView.addConstraints([contentView.relationWidth(to: scrollView),
                                   contentView.relationHeight(to: scrollView)])
        contentView.addSubviewForLayout(titleLandingLb)
        contentView.addConstraints([titleLandingLb.alignTop(to: contentView, space: 30),
                                    titleLandingLb.relationCenterX(to: contentView)])
        
        contentView.addSubviewForLayout(driverWrapperView)
        contentView.addConstraints([driverWrapperView.spacingTop(to: titleLandingLb, space: 30),
                                    driverWrapperView.alignLeading(to: contentView, space: 90),
                                    driverWrapperView.alignTrailing(to: contentView, space: 90)])
        driverWrapperView.addConstraints([driverWrapperView.configWidth(ViewService.screenSize().width - 180),
                                          driverWrapperView.configHeight(ViewService.screenSize().width - 180)])
        driverWrapperView.addChildView(drirerAvatarImageView)
        driverWrapperView.addSubviewForLayout(driverTitleLb)
        driverWrapperView.addConstraints([driverTitleLb.alignBottom(to: driverWrapperView, space: 10),
                                           driverTitleLb.alignTrailing(to: driverWrapperView),
                                           driverTitleLb.alignLeading(to: driverWrapperView)])
        
        
        
        contentView.addSubviewForLayout(userWrapperView)
        contentView.addConstraint(userWrapperView.spacingTop(to: driverWrapperView,space: 60))
        userWrapperView.addConstraints([userWrapperView.configHeight(ViewService.screenSize().width - 180),
                                        userWrapperView.configWidth(ViewService.screenSize().width - 180)])
        contentView.addConstraints([userWrapperView.alignTrailing(to: contentView, space: 90),
                                    userWrapperView.alignTrailing(to: contentView, space: 90)])
        
        userWrapperView.addChildView(userAvatarImageView)
        userWrapperView.addSubviewForLayout(userTitleLb)
        userWrapperView.addConstraints([userTitleLb.alignBottom(to: userWrapperView, space: 10),
                                    userTitleLb.alignTrailing(to: userWrapperView),
                                    userTitleLb.alignLeading(to: userWrapperView)])
        
        driverWrapperView.addShadow()
        driverWrapperView.backgroundColor = .white
        driverWrapperView.clipsToBounds = false
        driverWrapperView.layer.masksToBounds = false
        driverWrapperView.layer.cornerRadius = 10
        driverWrapperView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(driverWrapperView_Tap(tapGesture:))))
        
        userWrapperView.addShadow()
        userWrapperView.backgroundColor = ColorSystem.white
        userWrapperView.clipsToBounds = false
        userWrapperView.layer.masksToBounds = false
        userWrapperView.layer.cornerRadius = 10
        userWrapperView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(userWrapperView_Tap(tapGesture:))))
        
        
        titleLandingLb.textAlignment = .center
        drirerAvatarImageView.setImage(assetId: .iconDriverHome)
        drirerAvatarImageView.contentMode = .scaleAspectFit
        driverTitleLb.textAlignment = .center
        driverTitleLb.font = FontSystem.sectionTitle
        driverTitleLb.textColor = ColorSystem.black
        userAvatarImageView.setImage(assetId: .iconUserHome)
        userAvatarImageView.contentMode = .scaleAspectFit
        userTitleLb.textAlignment = .center
        userTitleLb.font = FontSystem.sectionTitle
        userTitleLb.textColor = ColorSystem.black
        
        setupLocalized()
    }
    
    func setupLocalized() {
        titleLandingLb.text = "Example title"
        driverTitleLb.text = "TÀI XẾ"
        userTitleLb.text = "KHÁCH HÀNG"
    }
    
    @objc func driverWrapperView_Tap(tapGesture: UITapGestureRecognizer) {
        ViewService.showLoadingIndicator()
        print(">>> isShowed")
        DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
            print(">>> isShowed == false")
            ViewService.hideLoadingIndicator()
        }
    }
    
    @objc func userWrapperView_Tap(tapGesture: UITapGestureRecognizer) {
        
    }
    
}

extension LandingViewConroller: LandingViewProtocol {
    func startLoading() {
        
    }
    
    func endLoading() {
        
    }
}
