//
//  RegisterPresenter.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 9/10/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

class RegisterPresenter: RegisterPresenterProtocol {
    weak var view: RegisterViewProtocol?
    var wireFrame: RegisterWireFrameProtocol?
    var interactor: RegisterInteractorInputProtocol?
    
    func sendRequest(_ userRegister: UserRegister) {
        if let interactor = interactor {
            interactor.sendRequest(userRegister)
        }
    }
    
}

extension RegisterPresenter: RegisterInteractorOutputProtocol {
    func didSendRequestSuccess() {
        if let view = view {
            view.didSendRequestSuccess()
        }
    }
    
    func didSendRequestFail() {
        if let view = view {
            view.didSendRequestFail()
        }
    }
}
