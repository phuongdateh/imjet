//
//  ViewService.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 8/22/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import UIKit
import SVProgressHUD

final class ViewService {
    // MARK: - Screen Size
    class func screenSize() -> CGSize {
        return UIScreen.main.bounds.size
    }
    
    // MARK: Storyboard
    /**
     Method returns an instance of the view controller defined by the storyboard Id paramter from the storyboard defined by the storyboardName parameter
     - Parameter storyboardId: String
     - Parameter storyboardName: String
     - Returns: UIViewController?
     */
    class func viewController(_ storyBoardId: String, _ storyBoardName: String) -> UIViewController? {
        let storyBoard = UIStoryboard(name: storyBoardName, bundle: Bundle.main)
        let viewController: AnyObject = storyBoard.instantiateViewController(withIdentifier: storyBoardId)
        return viewController as? UIViewController
    }
    
    /**
     Method returns an instance of a nib defined by the name String parameter
     - Parameter name: String
     - Returns: UINib?
     */
    class func nib(_ name: String) -> UINib? {
        return UINib(nibName: name, bundle: Bundle.main)
    }
    
    /**
     Method returns an instance of a view defined by the nib name String parameter
     - Parameter nibName: String
     - Returns: UIView?
     */
    class func viewFrom(_ nibName: String) -> UIView? {
        let objects = Bundle.main.loadNibNamed(nibName, owner: nil, options: nil)
        if objects!.count > 0 {
            return objects![0] as? UIView
        }
        return nil
    }
    
    // MARK: UITableView
    /**
     Method registers a nib name defined by the nibName String parameter with the tableview given by the tableview parameter
     - Parameter nibName:        String
     - Parameter tableView: UITableView
     */
    class func registerNibWithTableView(_ nibName: String, tableView: UITableView) {
        let nib = ViewService.nib(nibName)
        tableView.register(nib, forCellReuseIdentifier: nibName)
    }
    
    // MARK: UICollectionView
    /**
     Method registers a nib name defined by the nibName String parameter with the collectionView given by the collectionView parameter
     - Parameter nibName:        String
     - Parameter collectionView: UICollectionView
     */
    class func registerNibWithCollectionView(_ nibName: String, collectionView: UICollectionView) {
        collectionView.register(ViewService.nib(nibName), forCellWithReuseIdentifier: nibName)
    }
    
    /**
     Method to find top most view controller
     - Returns: UIViewController?
     */
    class func findTopMostViewController()-> UIViewController? {
        if var topController = UIApplication.shared.keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        return nil
    }
    
    /**
     Method to clear all upper view hierarchy to prepare for deallocation, add completedAction such as set viewController to nil to deallocate after clear all view controller hierarchy
     - Parameter viewController: UIViewController
     - Parameter completedAction: ()->()?
     */
    class func clearViewController(viewController: UIViewController, completedAction: (()->())? = nil) {
        clear(viewController: viewController)
        if let completedAction = completedAction {
            completedAction()
        }
    }
    
    class func clear(viewController: UIViewController) {
        if let presentedViewController = viewController.presentedViewController {
            clear(viewController: presentedViewController)
            return
        }
        else if let tabBarController = viewController as? UITabBarController, checkIfTabBarControllerIsCleared(tabBarController: tabBarController) == false {
            if let viewControllers = tabBarController.viewControllers {
                for tabBarViewController in viewControllers {
                    clear(viewController: tabBarViewController)
                }
            }
            clear(viewController: tabBarController)
            return
        }
        else if let navigationController = viewController as? UINavigationController, checkIfNavigationControllerIsCleared(navigationController: navigationController) == false{
            navigationController.viewControllers = [navigationController.viewControllers[0]]
            clear(viewController: navigationController)
            return
        }
        else if let presentingViewController = viewController.presentingViewController {
            viewController.dismiss(animated: false, completion: {
                clear(viewController: presentingViewController)
            })
            return
        }
    }
    
    /**
        SVProgress
     */
    class func showLoadingIndicator() {
        ActivityIndicatorView.sharedInstance.beginLoading()
    }
    
    class func hideLoadingIndicator() {
        ActivityIndicatorView.sharedInstance.endLoading()
    }
    
    class func checkIfTabBarControllerIsCleared(tabBarController: UITabBarController) -> Bool {
        if let viewControllers = tabBarController.viewControllers {
            let fillerViewController = viewControllers.filter ({ (vc) -> Bool in
                if vc.presentingViewController == nil && vc.presentedViewController == nil {
                    if let vc = vc as? UINavigationController {
                        return checkIfNavigationControllerIsCleared(navigationController: vc)
                    }
                    else {
                        return true
                    }
                }
                return false
            })
            if fillerViewController.count == viewControllers.count {
                return true
            }
            return false
        }
        return true
    }
    
    
    class func checkIfNavigationControllerIsCleared(navigationController: UINavigationController) -> Bool {
        if navigationController.viewControllers.count == 1 {
            return true
        }
        return false
    }
    class func checkIfViewControllerIsCleared(viewController: UIViewController) -> Bool {
        if viewController.presentingViewController == nil, viewController.presentedViewController == nil {
            return true
        }
        return false
    }
    
    // ShowHideView
    class func renderShowHideView(isShow: Bool, zeroConstraint: NSLayoutConstraint,_ bottomConstraint: NSLayoutConstraint) {
        zeroConstraint.isActive = !isShow
        bottomConstraint.isActive = isShow
    }
    
    
    
    
}
