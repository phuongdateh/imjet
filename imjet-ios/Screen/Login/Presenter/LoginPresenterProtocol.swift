//
//  LoginPresenterProtocol.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 8/27/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

protocol LoginPresenterProtocol: class {
    var wireFrame: LoginWireFrameProtocol? { get set }
    var view: LoginViewProtocol? { get set }
    var interactor: LoginInteractorInputProtocol? { get set }
    
    func pushInputPhoneNUmber()
    func loginByFacebook(token: String)
    func loginByGoogle(token: String)
    func loginByPhone(_ userLogin: UserLogin)
}
