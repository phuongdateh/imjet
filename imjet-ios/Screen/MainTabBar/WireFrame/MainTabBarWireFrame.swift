//
//  MainTabBarWireFrame.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 10/24/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import UIKit

class MainTabBarWireFrame: MainTabBarWireFrameProtocol {
    static func createMainTabBarController(_ lauchOptions: [UIApplication.LaunchOptionsKey : Any]?) -> MainTabBarController? {
        if let vc = ViewService.viewController(MainTabBarController.storyBoardId(), MainTabBarController.storyBoardName()) as? MainTabBarController {
            
            vc.lauchOptions = lauchOptions
            vc.setupChild()
            
            return vc
        }
        return nil
    }
}

