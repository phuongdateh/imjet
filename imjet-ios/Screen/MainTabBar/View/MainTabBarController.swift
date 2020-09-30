//
//  MainTabBarController.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 10/23/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import UIKit

class MainTabBarController: UITabBarController {
    
    // MARK: - Metadata
    class func storyBoardId() -> String {
        return "MainTabBarController"
    }
    
    class func storyBoardName() -> String {
        return "MainTabBar"
    }
    
    // MARK: - Properties
    var lauchOptions: [UIApplication.LaunchOptionsKey: Any]?
    
    // MARK: - Lyfe cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let viewControllers = viewControllers {
            for viewController in viewControllers {
                viewController.tabBarItem.imageInsets = UIEdgeInsets.init(top: 5.5, left: 0, bottom: -5.5, right: 0)
            }
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if lauchOptions != nil {
            handleLaunchOptions()
        }
    }
    
    deinit {
        print("Deinit: MainTabBarController")
    }
    
    func  handleLaunchOptions() {
        if let lauchOptions = lauchOptions {
            if let notification = lauchOptions[.remoteNotification] as? [String: AnyObject] {
                NotificationService.sharedInstance.handleNotification(info: notification)
            }
            else {
                ToastView.sharedInstance.showContent("Oh year")
            }
        }
        lauchOptions = nil
    }
    
    func setupChild() {
        guard let homeVC = ProvicePurposeWireFrame.createProvicePurposeViewController() else { return }
        homeVC.tabBarItem.image = UIImage.init(assetId: .iconHomeTabbar)
        let homeNavigationController = MainNavigationController.init(rootViewController: homeVC)
        
        guard let profileVC = ProfileWireFrame.createProfileViewController() else { return }
        profileVC.tabBarItem.image = UIImage.init(assetId: .iconProfileTabbar)
        let profileNavigationController = MainNavigationController.init(rootViewController: profileVC)
        
        guard let orderListVC = JourneyListWireFrame.createOrderListViewController() else { return }
        orderListVC.tabBarItem.image = UIImage.init(assetId: .iconOrderTabbar)
        let orderListNavigationController = MainNavigationController.init(rootViewController: orderListVC)
        
        self.viewControllers = [homeNavigationController, orderListNavigationController, profileNavigationController]
    }
}
