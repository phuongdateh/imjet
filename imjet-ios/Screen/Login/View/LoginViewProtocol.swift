//
//  LoginViewProtocol.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 8/27/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

protocol LoginViewProtocol: class {
    var presenter: LoginPresenterProtocol? { get set }
    
    func didLoginByFacebookSuccess()
    func didLoginByFacebookFail()
    func didLoginByGoogleSuccess()
    func didLoginByGoogleFail()
    func didLoginByPhoneSuccess()
    func didLoginByPhoneFail(_ errorCode: Int)
}
