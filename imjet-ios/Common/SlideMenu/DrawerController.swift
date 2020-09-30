//
//  DrawerController.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 8/30/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import UIKit

class DrawerController: UIViewController {
    
    var rootViewController: RootViewController
    var menuController: SlideMenuViewController
    
    var isMenuExpand: Bool = false
    var overlayView: UIView = UIView()
    
    init(rootViewController: RootViewController, menuController: SlideMenuViewController) {
        self.rootViewController = rootViewController
        self.menuController = menuController
        super.init(nibName: nil, bundle: nil)
        self.rootViewController.rootDelegate = self
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        self.addChild(rootViewController)
//        self.view.addSubview(rootViewController.view)
//        rootViewController.didMove(toParent: self)
//
//        overlayView.backgroundColor = .black
//        overlayView.alpha = 0
//        view.addSubview(overlayView)
//
//        self.menuController.view.frame = CGRect.init(x: 0, y: 0, width: 0, height: self.view.bounds.height)
//        self.addChild(menuController)
//        self.view.addSubview(menuController.view)
//        menuController.didMove(toParent: self)
        
        
        configureGestures()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        overlayView.frame = view.bounds
        let width: CGFloat = (isMenuExpand) ? view.bounds.width * 2 / 3 : 0.0
        self.menuController.view.frame = CGRect(x: 0, y: 0, width: width , height: self.view.bounds.height)
        
    }
    
    func toggleMenu() {
//        isMenuExpand != isMenuExpand
        let bounds = self.view.bounds
        let width: CGFloat = (isMenuExpand) ? bounds.width * 2 / 3 : 0.0
        
        UIView.animate(withDuration: 0.3, animations: {
            self.menuController.view.frame = CGRect(x: 0, y: 0, width: width, height: bounds.height)
            self.overlayView.alpha = (self.isMenuExpand) ? 0.5 : 0.0
        }) { (success) in
            
        }
    }
    
    func navigateTo(viewController: UIViewController) {
        rootViewController.setViewControllers([viewController], animated: true)
        self.toggleMenu()
    }
    
    fileprivate func configureGestures() {
        let swipeLeftGesture = UISwipeGestureRecognizer.init(target: self, action: #selector(didSwipeLeft))
        swipeLeftGesture.direction = .left
        overlayView.addGestureRecognizer(swipeLeftGesture)
        
        let tapGesture = UITapGestureRecognizer.init(target: self, action: #selector(didTapOverlay))
        overlayView.addGestureRecognizer(tapGesture)
    }
    
    @objc func didSwipeLeft() {
        toggleMenu()
    }
    
    @objc func didTapOverlay() {
        toggleMenu()
    }
}

extension DrawerController: RootViewControllerDelegate {
    func rootViewControlletDidTapMenuButton(_ rootViewController: RootViewController) {
        
    }
}
