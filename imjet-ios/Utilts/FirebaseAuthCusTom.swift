//
//  FirebaseAuth.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 9/14/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import FirebaseAuth



final class FirebaseAuthCustom {
    static let sharedInstance: FirebaseAuthCustom = {
        var auth = FirebaseAuthCustom()
        return auth
    }()
    
    var verificationId: String = ""
    
    func verify() {
        
    }
    
    func verifyPhoneNumber(_ phoneNumber: String) -> () {
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumber, uiDelegate: nil) { [weak self] (verificationId, error) in
            if let error = error {
                print("Error verify phone: \(error.localizedDescription)")
            }
            else if let verificationId = verificationId, let weakSelf = self {
                weakSelf.verificationId = verificationId
            }
        }
    }
    
    func verifyCode(_ verificationId: String, code: String) -> Bool {
        var isVerified: Bool = false
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationId, verificationCode: code)
        
        Auth.auth().signIn(with: credential) { (authResult, error) in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                isVerified = false
            }
            else {
                isVerified = true
            }
        }
        return isVerified
    }
    
    func getVerificationId() -> String? {
        return verificationId
    }
    
    func updateFCMToken(_ notiFCM: NotificationFCM) {
        APIServiceManager.sharedInstance.loginFCM(notiFCM: notiFCM) { (errorPackage, responsePackage) in
            if let errorPackage = errorPackage, let code = errorPackage.code {
                Log.error("Update FCMToken Fail: \(code)")
                return
            }
            else if let responsePackage = responsePackage, let value = responsePackage.value as? [String: AnyObject], let data = value[Constants.kData] as? [String: AnyObject] {
                if let registrationToken = data[Constants.kRegistrationToken] as? String {
                    AuthenticationService.updateFCMTokenLocal(registrationToken: registrationToken)
                }
                Log.info("😊😊😊 Update FCMToken success 😊😊😊")
                return
            }
        }
    }
    
    func logoutFCMToken(_ notiFCM: NotificationFCM) {
        APIServiceManager.sharedInstance.logoutFCM(notiFCM: notiFCM) { (errorPackage, responsePackage) in
            UserDefaults.standard.removeObject(forKey: Constants.kAccessToken)
            if let errorPackage = errorPackage, let code = errorPackage.code {
                Log.error("Logout FCM Fail : \(code)")
                return
            }
            else if let responsePackage = responsePackage, let statusCode = responsePackage.code, statusCode == 200 {
                Log.info("Logout FCM success")
                return
            }
        }
    }
}
