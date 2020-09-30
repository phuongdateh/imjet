//
//  RootViewController.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 8/30/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import UIKit

protocol RootViewControllerDelegate: class {
    func rootViewControlletDidTapMenuButton(_ rootViewController: RootViewController)
}

class RootViewController: UINavigationController {
    
    private var menuButton: UIBarButtonItem?
    private var iconImage: UIImage?
    weak var rootDelegate: RootViewControllerDelegate?
    
    public init(mainViewController: UIViewController, iconImage: UIImage) {
        super.init(rootViewController: mainViewController)
        self.iconImage = iconImage
        menuButton = UIBarButtonItem.init(image: iconImage, style: .plain, target: self, action: #selector(handleMenuButton_Tap))
    }
    
    public override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.delegate = self
    }
}

extension RootViewController {
    @objc fileprivate func handleMenuButton_Tap() {
        if let rootDelegate = rootDelegate {
            rootDelegate.rootViewControlletDidTapMenuButton(self)
        }
    }
    
    fileprivate func prepareNavigationBar() {
        if let topViewController = topViewController {
            topViewController.navigationItem.title = topViewController.title
            if self.viewControllers.count <= 1 {
                topViewController.navigationItem.leftBarButtonItem = menuButton
            }
        }
    }
}

extension RootViewController: UINavigationControllerDelegate {
    public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        prepareNavigationBar()
    }
}
