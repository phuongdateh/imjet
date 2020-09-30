//
//  LoginInteractor.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 9/7/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

class LoginInteractor: LoginInteractorInputProtocol {
    var presenter: LoginInteractorOutputProtocol?
    var remoteDataManager: LoginRemoteDataManagerInputProtocol?
    
    func loginByGoogle(token: String) {
        if let remoteDataManager = remoteDataManager {
            remoteDataManager.loginByGoogle(token: token)
        }
    }
    
    func loginByFacebook(token: String) {
        if let remoteDataManager = remoteDataManager {
            remoteDataManager.loginByFacebook(token: token)
        }
    }
    
    func loginByPhone(_ userLogin: UserLogin) {
        if let remoteDataManager = remoteDataManager {
            remoteDataManager.loginByPhone(userLogin)
        }
    }
    
}

extension LoginInteractor: LoginRemoteDataManagerOutputProtocol {
    func didLoginByPhoneSuccess() {
        if let presenter = presenter {
            presenter.didLoginByPhoneSuccess()
        }
    }
    
    func didLoginByPhoneFail(_ errorCode: Int) {
        if let presenter = presenter {
            presenter.didLoginByPhoneFail(errorCode)
        }
    }
    
    func didLoginByGoogleFail() {
        if let presenter = presenter {
            presenter.didLoginByGoogleFail()
        }
    }
    
    func didLoginByFacebookFail() {
        if let presenter = presenter {
            presenter.didLoginByFacebookFail()
        }
    }
    
    func didLoginByGoogleSuccess() {
        if let presenter = presenter {
            presenter.didLoginByGoogleSuccess()
        }
    }
    
    func didLoginByFacebookSuccess() {
        if let presenter = presenter {
            presenter.didLoginByFacebookSuccess()
        }
    }
}
