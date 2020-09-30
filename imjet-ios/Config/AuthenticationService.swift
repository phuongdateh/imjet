//
//  AuthenticationService.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 9/14/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import UIKit

final class AuthenticationService {
    
    /// get token idCloud
    class func getTokenIdCloud() {
        if let currentToken = FileManager.default.ubiquityIdentityToken {
            print(currentToken)
            
        }
    }
    
    /// Set fcm for local
    class func setFCMToken(registrationToken: String) {
        UserDefaults.standard.setValue(registrationToken, forKey: Constants.kRegistrationToken)
    }
    
    /// Update fcm from server
    class func updateFCMTokenLocal(registrationToken: String) {
        UserDefaults.standard.removeObject(forKey: Constants.kRegistrationToken)
        UserDefaults.standard.setValue(registrationToken, forKey: Constants.kRegistrationToken)
    }
    
    /// Registertration for Notificationsion
    static var fcmToken: String? {
        return (UserDefaults.standard.object(forKey: Constants.kRegistrationToken) as? String)
    }
    
    /// AccessToken when login success
    static var accessToken: String? {
        return (UserDefaults.standard.object(forKey: Constants.kAccessToken) as? String)
    }
    
    static var isPhoneVerifed: Bool {
        if (UserDefaults.standard.object(forKey: Constants.kPhoneNumberVerified) as? String) != nil {
            return true
        }
        return false
    }
    
    static var currentPhone: String? {
        return (UserDefaults.standard.object(forKey: Constants.kPhoneProfile) as? String)
    }
    
    static var phoneNumberVerified: String? {
        return (UserDefaults.standard.object(forKey: Constants.kPhoneNumberVerified) as? String)
    }
    
    static var isAuthoried: Bool {
        if (UserDefaults.standard.object(forKey: Constants.kAccessToken) as? String) != nil {
            return true
        }
        return false
    }
    
    class func logout() {
        var fcmTokenStr = ""
        if let fcmToken = AuthenticationService.fcmToken {
            fcmTokenStr = fcmToken
        }
        let notiFCM = NotificationFCM.init(fcmTokenStr)
        APIServiceManager.sharedInstance.logoutFCM(notiFCM: notiFCM) { (errorPackage, responsePackage) in
            UserDefaults.standard.removeObject(forKey: Constants.kAccessToken)
            if let errorPackage = errorPackage, let code = errorPackage.code {
                Log.error("LogoutFCM: \(code)")
                return
            }
            else if let responsePackage = responsePackage, let statusCode = responsePackage.code, statusCode == 200 {
                Log.info("Logout FCM token Success")
                return
            }
        }
        UserDefaults.standard.removeObject(forKey: Constants.currentUserId)
        UserDefaults.standard.removeObject(forKey: Constants.kProfileId)
        lauchLoginView()
    }
    
    class func lauchLoginView() {
        if let loginVC = LoginWireFrame.createLoginViewController() {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            JETLocationManager.sharedInstance.startGettingLocation()
            if let tabBarController = appDelegate.window?.rootViewController as? MainTabBarController {
                ViewService.clearViewController(viewController: tabBarController) {
                    tabBarController.viewControllers = nil
                    appDelegate.window = UIWindow.init(frame: UIScreen.main.bounds)
                    let navigationController = MainNavigationController.init(rootViewController: loginVC)
                    appDelegate.window?.rootViewController = navigationController
                    appDelegate.window?.makeKeyAndVisible()
                }
            }
            else {
                let navigationController = MainNavigationController.init(rootViewController: loginVC)
                appDelegate.window = UIWindow.init(frame: UIScreen.main.bounds)
                appDelegate.window?.rootViewController = navigationController
                appDelegate.window?.makeKeyAndVisible()
            }
        }
    }
    
    class func lauchHomeView(_ lauchOptions: [UIApplication.LaunchOptionsKey: Any]?) {
        if let tabBar = MainTabBarWireFrame.createMainTabBarController(lauchOptions) {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            appDelegate.window = UIWindow.init(frame: UIScreen.main.bounds)
            appDelegate.window?.rootViewController = tabBar
            appDelegate.window?.makeKeyAndVisible()
            JETLocationManager.sharedInstance.startGettingLocation()
        }
    }
}
