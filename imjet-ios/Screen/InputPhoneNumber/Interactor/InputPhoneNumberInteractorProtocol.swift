//
//  InputPhoneNumberInteractorProtocol.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 9/12/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

protocol InputPhoneNumberInteractorInputProtocol: class {
    var presenter: InputPhoneNumberInteractorOutputProtocol? { get set }
    var remoteDataManager: InputPhoneNumberRemoteDataManagerInputProtocol? { get set }
    
    func verifyPhone(_ phone: VerifyPhone)
}

protocol InputPhoneNumberInteractorOutputProtocol: class {
    func didSendVerifyPhoneSuccess(code: Int)
    func didSendVerifyPhoneFail(code: Int)
}
