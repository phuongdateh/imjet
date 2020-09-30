//
//  InputPhoneNumberRemoteDataManagerProtocol.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 9/12/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

protocol InputPhoneNumberRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: InputPhoneNumberRemoteDataManagerOutputProtocol? { get set}

    func verifyPhone(_ phone: VerifyPhone)
}

protocol InputPhoneNumberRemoteDataManagerOutputProtocol: class {
    func didSendVerifyPhoneSuccess(code: Int)
    func didSendVerifyPhoneFail(code: Int)
}
