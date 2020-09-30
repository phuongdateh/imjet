//
//  RegisterRemoteDataManager.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 9/10/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

class RegisterRemoteDataManager: RegisterRemoteDataManagerInputProtocol {
    var remoteRequestHandler: RegisterRemoteDataManagerOutputProtocol?
    
    func sendRequest(_ userRegister: UserRegister) {
        APIServiceManager.sharedInstance.registerByPhone(userRegister) { [weak self](errorPackage, responsePackage) in
            if let errorPackage = errorPackage, let code = errorPackage.code {
                print(code)
                if let weakSelf = self, let remoteRequestHandler = weakSelf.remoteRequestHandler {
                    remoteRequestHandler.didSendRequestFail()
                }
            }
            else if let responsePakage = responsePackage, let value = responsePakage.value as? [String: AnyObject], let data = value["data"] as? [String: AnyObject] {
                print(data)
                if let weakSelf = self, let remoteRequestHandler = weakSelf.remoteRequestHandler {
                    remoteRequestHandler.didSendRequestSuccess()
                }
            }
        }
    }
}

