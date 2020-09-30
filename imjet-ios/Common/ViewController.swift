//
//  ViewController.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 8/21/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - Properties
    private var isFirstTimesAppeared: Bool = true
    private var initNavigationTitle: String = ""
    private var isAppeared: Bool = false
    var backBarButton: UIBarButtonItem?
    private var leftTitleBar: UIBarButtonItem!
    
    
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        navigationItem.title = initNavigationTitle
        view.addGestureRecognizer(UITapGestureRecognizer.init(target: self.view, action: #selector(UIView.endEditing(_:))))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        // setup custom title view
        isAppeared = true
        
        navigationItem.title = initNavigationTitle
        addBackButton()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        isAppeared = true
        if isFirstTimesAppeared == true {
            isFirstTimesAppeared = false
            firstTimeAppeared()
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        isAppeared = false
    }
    
    func  firstTimeAppeared() {
        
    }
    
    deinit {
        print("deinit: \(self.classForCoder)")
        //deinit something
        // notification, userdefaul, cache
        
    }
    
    
    /**
     Use this function to setNavigationTitle, so you don't need to set it in viewDidLoad, make you code cleaner. However. if you want to change navigation title during runtime, please set it manually
     */
    final func setNavigationTitle(_ title: String){
        initNavigationTitle = title
    }
    
    // MARK: - Metadata
    class func storyBoardId() -> String {
        return ""
    }
    
    class func storyBoardName() -> String {
        return ""
    }
    
    class func initWithStoryboard() -> ViewController? {
        return ViewService.viewController(storyBoardId(), storyBoardName()) as? ViewController
    }
    
    func addBackButton() {
        if let navigationController = navigationController {
            let viewControllers = navigationController.viewControllers
            if let index = viewControllers.firstIndex(of: self), index > 0 {
                backBarButton = createBarView(image: UIImage.init(assetId: .back_arrow), defaultTintColor: .black, style: .left)
                navigationItem.leftBarButtonItem = backBarButton
            }
            else if let index = viewControllers.firstIndex(of: self), index == 0, let _ = navigationController.presentingViewController {
                //create button close view controller
                backBarButton = createBarView(image: UIImage.init(assetId: .cross), defaultTintColor: .black, style: .left)
                navigationItem.leftBarButtonItem = backBarButton
            }
        }
    }
    
    @objc func barButtonDidTouch(_ button: UIBarButtonItem) {
        print("barButtonDidTouch")
        if let navigationController = navigationController {
            let viewControllers = navigationController.viewControllers
            if let backBarButton = backBarButton, backBarButton == button {
                if let index = viewControllers.index(of: self), index > 0 {
                    navigationController.popViewController(animated: true)
                }
                else if let index = viewControllers.index(of: self), index == 0 , let _ = navigationController.presentationController {
                    if let tabBarController = tabBarController {
                        tabBarController.dismiss(animated: true, completion: nil)
                    }
                    else {
                        navigationController.dismiss(animated: true, completion: nil)
                    }
                }
                else {
                    dismiss(animated: true, completion: nil)
                }
            }
        }
        
    }
    
    func createBarView(image: UIImage?, defaultTintColor: UIColor, style: BarButtonViewStyle) -> UIBarButtonItem {
        let barButtonItem = UIBarButtonItem.init(image: image, style: .plain, target: self, action: #selector(barButtonDidTouch(_:)))
        barButtonItem.tintColor = defaultTintColor
        return barButtonItem
    }
}

