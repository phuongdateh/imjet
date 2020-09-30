//
//  InputPhoneNumberRemoteDataManager.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 9/12/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

class InputPhoneNumberRemoteDataManager: InputPhoneNumberRemoteDataManagerInputProtocol {
    var remoteRequestHandler: InputPhoneNumberRemoteDataManagerOutputProtocol?
    
    func verifyPhone(_ phone: VerifyPhone) {
        
        APIServiceManager.sharedInstance.verifyPhone(phone) { [weak self] (errorPackage, responsePackage) in
            if let error = errorPackage, let code = error.code {
                if let weakSelf = self, let remoteRequestHandler = weakSelf.remoteRequestHandler {
                    remoteRequestHandler.didSendVerifyPhoneFail(code: code)
                }
                return
            }
            else if let response = responsePackage, let value = response.value as? [String: AnyObject], let data = value["data"] as? [String: AnyObject], let code = data["code"] as? Int {
                if let weakSelf = self, let remoteRequestHandler = weakSelf.remoteRequestHandler {
                    remoteRequestHandler.didSendVerifyPhoneSuccess(code: code)
                }
                return
            }
            else {
                ToastView.sharedInstance.showContent("Some Error From Server Off")
            }
        }
    }
}
