//
//  InputPhoneNumberViewProtocol.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 9/12/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

protocol InputPhoneNumberViewProtocol: class {
    var presenter: InputPhoneNumberPresenterProtocol? { get set }
    
    func didSendVerifyPhoneSuccess(code: Int)
    func didSendVerifyPhoneFail(code: Int)
}
