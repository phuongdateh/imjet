//
//  InputPhoneNumberPresenter.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 9/12/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

class InputPhoneNumberPresenter: InputPhoneNumberPresenterProtocol {
    weak var view: InputPhoneNumberViewProtocol?
    var wireFrame: InputPhoneNumberWireFrameProtocol?
    var interactor: InputPhoneNumberInteractorInputProtocol?
    
    func verifyPhone(phone: VerifyPhone) {
        if let interactor = interactor {
            interactor.verifyPhone(phone)
        }
    }
    
    func pushInputCode(_ verificationId: String, _ phoneNumber: String) {
        if let wireFrame = wireFrame, let view = view {
            wireFrame.pushInputCode(from: view, verificationId, phoneNumber)
        }
    }
    
    func pushRegister(_ phoneNumber: String) {
        if let wireFrame = wireFrame, let view = view {
            wireFrame.pushRegister(from: view, phoneNumber)
        }
    }
}

extension InputPhoneNumberPresenter: InputPhoneNumberInteractorOutputProtocol {
    func didSendVerifyPhoneSuccess(code: Int) {
        if let view = view {
            view.didSendVerifyPhoneSuccess(code: code)
        }
    }
    
    func didSendVerifyPhoneFail(code: Int) {
        if let view = view {
            view.didSendVerifyPhoneFail(code: code)
        }
    }
}
