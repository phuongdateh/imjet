//
//  InputPhoneNumberInteractor.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 9/12/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

class InputPhoneNumberInteractor: InputPhoneNumberInteractorInputProtocol {
    var presenter: InputPhoneNumberInteractorOutputProtocol?
    var remoteDataManager: InputPhoneNumberRemoteDataManagerInputProtocol?
    
    func verifyPhone(_ phone: VerifyPhone) {
        if let remoteDataManager = remoteDataManager {
            remoteDataManager.verifyPhone(phone)
        }
    }
}

extension InputPhoneNumberInteractor: InputPhoneNumberRemoteDataManagerOutputProtocol {
    func didSendVerifyPhoneSuccess(code: Int) {
        if let presenter = presenter {
            presenter.didSendVerifyPhoneSuccess(code: code)
        }
    }
    
    func didSendVerifyPhoneFail(code: Int) {
        if let presenter = presenter {
            presenter.didSendVerifyPhoneFail(code: code)
        }
    }
}
