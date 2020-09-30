//
//  AppDelegate.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 8/21/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import UIKit
import GoogleMaps
import GooglePlaces
import GoogleSignIn
import Firebase
import FirebaseMessaging
import IQKeyboardManagerSwift
import RealmSwift


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        setupLogger()
        Bundle.setLanguage("vi")
        initSplashScreen(launchOptions)
        
        UITabBar.appearance().tintColor = ColorSystem.white
        UITabBar.appearance().barTintColor = ColorSystem.black
        
        if #available(iOS 10.0, *) {
            UITabBar.appearance().unselectedItemTintColor = ColorSystem.lightGray
        } else {
            
        }
    
        GMSServices.provideAPIKey(Constants.apiKey)
        GMSPlacesClient.provideAPIKey(Constants.apiKey)
        
        GIDSignIn.sharedInstance().clientID = Constants.clientID
        
        FirebaseApp.configure()
        Auth.auth().languageCode = "vn"
        
        IQKeyboardManager.shared.enable = true
       
        self.registerForPushNotification()
        Messaging.messaging().delegate = self
        
        let config = Realm.Configuration(
            // Set the new schema version. This must be greater than the previously used
            // version (if you've never set a schema version before, the version is 0).
            schemaVersion: 1,
            migrationBlock: { migration, oldSchemaVersion in
                print("Migration Realm")
        })
    
        Realm.Configuration.defaultConfiguration = config
        
        _ = try! Realm()

        return true
    }
    
    func registerForPushNotification() {
        if #available(iOS 10.0, *) {
            let center  = UNUserNotificationCenter.current()
            center.delegate = self
            center.requestAuthorization(options: [.sound, .alert, .badge]) { (granted, error) in
                if error == nil{
                    DispatchQueue.main.async {
                        UIApplication.shared.registerForRemoteNotifications()
                    }
                }
            }
        } else {
            let settings = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(settings)
            UIApplication.shared.registerForRemoteNotifications()
        }
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
//    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any]) {
//        if (application.applicationState == UIApplication.State.inactive || application.applicationState == UIApplication.State.background) {
//            NotificationService.sharedInstance.handleNotification(info: userInfo)
//        }
//        else {
//
//            ToastNotificationView.sharedInstance.show(with: userInfo)
//        }
//         Log.verbose("Noti1 121312")
//    }
    
    func application(_ application: UIApplication, didReceiveRemoteNotification userInfo: [AnyHashable : Any], fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        if (application.applicationState == UIApplication.State.inactive || application.applicationState == UIApplication.State.background) {
            NotificationService.sharedInstance.handleNotification(info: userInfo)
            Log.verbose("Noti inactive or background")
        }
        else {
            Log.verbose("Noti runing")
            ToastNotificationView.sharedInstance.show(with: userInfo)
        }
        
    }


}

extension AppDelegate: UNUserNotificationCenterDelegate {
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
        let token = tokenParts.joined()
        Log.info("APNs Device Token: \(token)")
        Messaging.messaging().apnsToken = deviceToken
    }
    
    func application(_ application: UIApplication,
                     didFailToRegisterForRemoteNotificationsWithError error: Error) {
        Log.error("Failed to register: \(error.localizedDescription)")
    }
    
//    @available(iOS 10.0, *)
//    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
//          
//
//        ToastView.sharedInstance.showContent("userNotificationCenter")
//        // tell the app that we have finished processing the user’s action / response
//        completionHandler()
//    }
}

extension AppDelegate: MessagingDelegate {
    func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
        Log.info("Received data message: \(remoteMessage.appData)")
    }
    
    func application(received remoteMessage: MessagingRemoteMessage) {

        
    }
    
    func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String) {
        let oldFCMToken = AuthenticationService.fcmToken
        if oldFCMToken == nil {
            AuthenticationService.setFCMToken(registrationToken: fcmToken)
        }
        else if oldFCMToken != fcmToken {
            FirebaseAuthCustom.sharedInstance.updateFCMToken(NotificationFCM.init(fcmToken))
        }
        Log.info("FCM Token: \(fcmToken)")
    }
}

extension AppDelegate {
    fileprivate func initSplashScreen(_ lauchOptions: [UIApplication.LaunchOptionsKey: Any]? ) {
        if let initVC = window?.rootViewController as? SplashViewController {
            initVC.launchOptions = lauchOptions
        }
    }
}
