//
//  LoginRemoteDataManager.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 9/7/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

class LoginRemoteDataManager: LoginRemoteDataManagerInputProtocol {
    weak var remoteRequestHandler: LoginRemoteDataManagerOutputProtocol?

    func loginByPhone(_ userLogin: UserLogin) {
        APIServiceManager.sharedInstance.loginByPhone(userLogin) { [weak self] (errorPackage, responsePackage) in
            if let errorPackage = errorPackage {
                if let value = errorPackage.value as? [String: AnyObject] {
                    if let errorData = value["errors"] as? [[String: AnyObject]] {
                        var errorCodeInt: Int = 0
                        for error in errorData {
                            if let errorCode = error["code"] as? Int {
                                errorCodeInt = errorCode
                            }
                        }
                        if let weakSelf = self, let remoteRequestHandler = weakSelf.remoteRequestHandler {
                            remoteRequestHandler.didLoginByPhoneFail(errorCodeInt)
                        }
                        return
                    }
                }
                return
            }
            else if let responsePackage = responsePackage, let value = responsePackage.value as? [String: AnyObject], let data = value[Constants.kData] as? [String: AnyObject] {
                // get userInfo with accessToken
                // call Api get userInfo, Realm save
                if let accessToken = data[Constants.kAccessToken] as? String {
                    print("AccessToken: \(accessToken)")
                }
                if let fcmToken = AuthenticationService.fcmToken {
                    FirebaseAuthCustom.sharedInstance.updateFCMToken(NotificationFCM.init(fcmToken))
                }
                if let weakSelf = self, let remoteRequestHandler = weakSelf.remoteRequestHandler {
                    remoteRequestHandler.didLoginByPhoneSuccess()
                }
                return
            }
            
            if let weakSelf = self, let remoteRequestHandler = weakSelf.remoteRequestHandler {
                remoteRequestHandler.didLoginByPhoneFail(0)
            }
            return
        }
    }
    
    func loginByGoogle(token: String) {
        APIServiceManager.sharedInstance.loginByGoogle(token: token) { [weak self] (errorPackage, responsePackage) in
            if let errorPackage = errorPackage, let code = errorPackage.code {
                print("ErrorCode: \(code)")
                if let weakSelf = self, let remoteRequestHandler = weakSelf.remoteRequestHandler {
                    remoteRequestHandler.didLoginByGoogleFail()
                }
            }
            else if let responsePackage = responsePackage {
                if let weakSelf = self, let remoteRequestHandler = weakSelf.remoteRequestHandler {
                    remoteRequestHandler.didLoginByGoogleSuccess()
                }
                return
            }
        }
    }
    
    func loginByFacebook(token: String) {
        APIServiceManager.sharedInstance.loginByFacebook(token: token) { [weak self] (errorPackage, responsePackage) in
            if let errorPackage = errorPackage, let code = errorPackage.code, code > 500 {
                if let weakSelf = self, let remoteRequestHandler = weakSelf.remoteRequestHandler {
                    remoteRequestHandler.didLoginByFacebookFail()
                }
            }
            else {
                if let weakSelf = self, let remoteRequestHandler = weakSelf.remoteRequestHandler {
                    remoteRequestHandler.didLoginByFacebookSuccess()
                }
            }
        }
    }
}
