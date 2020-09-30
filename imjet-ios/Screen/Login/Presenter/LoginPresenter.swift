//
//  LoginPresenter.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 8/27/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

class LoginPresenter: LoginPresenterProtocol {
    weak var view: LoginViewProtocol?
    var wireFrame: LoginWireFrameProtocol?
    var interactor: LoginInteractorInputProtocol?
    
    func pushInputPhoneNUmber() {
        if let wireFrame = wireFrame, let view = view {
            wireFrame.pushInputPhoneNumber(from: view)
        }
    }
    
    func loginByFacebook(token: String) {
        if let interactor = interactor {
            interactor.loginByFacebook(token: token)
        }
    }
    
    func loginByGoogle(token: String) {
        if let interactor = interactor {
            interactor.loginByGoogle(token: token)
        }
    }
    
    func loginByPhone(_ userLogin: UserLogin) {
        if let interactor = interactor {
            interactor.loginByPhone(userLogin)
        }
    }
}

extension LoginPresenter: LoginInteractorOutputProtocol {
    func didLoginByPhoneSuccess() {
        if let view = view {
            view.didLoginByPhoneSuccess()
        }
    }
    
    func didLoginByPhoneFail(_ errorCode: Int) {
        if let view = view {
            view.didLoginByPhoneFail(errorCode)
        }
    }
    
    func didLoginByFacebookSuccess() {
        if let view = view {
            view.didLoginByFacebookSuccess()
        }
    }
    
    func didLoginByGoogleSuccess() {
        if let view = view {
            view.didLoginByGoogleSuccess()
        }
    }
    
    func didLoginByFacebookFail() {
        if let view = view {
            view.didLoginByFacebookFail()
        }
    }
    
    func didLoginByGoogleFail() {
        if let view = view {
            view.didLoginByGoogleFail()
        }
    }
}
