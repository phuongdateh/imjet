//
//  UIViewController.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 9/1/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func customPresent(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)? = nil) {
        viewControllerToPresent.modalPresentationStyle = .fullScreen
        present(viewControllerToPresent, animated: true, completion: nil)
    }
    
    func popViewController() {
        if let navigationController = navigationController {
            let viewControllers = navigationController.viewControllers
            if let index = viewControllers.index(of: self), index > 0 {
                navigationController.popViewController(animated: true)
            }
            else if let index = viewControllers.firstIndex(of: self), index == 0, let _ = navigationController.presentingViewController {
                if let tabBarController = tabBarController {
                    tabBarController.dismiss(animated: true, completion: nil)
                }
                else if navigationController != nil {
                    navigationController.dismiss(animated: true, completion: nil)
                }
                else {
                    dismiss(animated: true, completion: nil)
                }
            }
        }
    }
    
    func popToProvicePurposeViewController() {
        if let navigationController = navigationController {
            let viewControllers = navigationController.viewControllers
            if let index = viewControllers.firstIndex(where: { (vc) -> Bool in
                if vc is ProvicePurposeViewController {
                    return true
                }
                return false
            }) {
                navigationController.popToViewController(viewControllers[index], animated: true)
                return
            }
        }
    }
    
    func presentOverContext(_ viewController: UIViewController, animated: Bool, completion: (() -> ())?) {
        viewController.modalPresentationStyle = UIModalPresentationStyle.overCurrentContext
        viewController.modalTransitionStyle = .crossDissolve
        viewController.modalPresentationCapturesStatusBarAppearance = true
        if let tabBarController = tabBarController {
            DispatchQueue.main.async {
                tabBarController.present(viewController, animated: false, completion: completion)
            }
        }
        else if let navigationController = navigationController {
            DispatchQueue.main.async {
                navigationController.present(viewController, animated: false, completion: completion)
            }
        }
        else {
            DispatchQueue.main.async { [weak self] in
                if let weakSelf = self {
                    weakSelf.present(viewController, animated: false, completion: completion)
                }
            }
        }
    }
    
    /// ADD title
    func addLeftTitle(title: String) {
        let titleLb = UILabel()
        titleLb.setFontAndTextColor(fontType: .bold, size: 20, color: UIColor.init(0x101010))
        titleLb.text = title
        let leftTitleBar = UIBarButtonItem.init(customView: titleLb)
        navigationItem.leftBarButtonItem = leftTitleBar
    }
}
