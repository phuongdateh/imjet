//
//  MainTabBarWireFrameProtocol.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 10/24/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import UIKit

protocol MainTabBarWireFrameProtocol: class {
    static func createMainTabBarController(_ lauchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> MainTabBarController?
}
