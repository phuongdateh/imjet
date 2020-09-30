//
//  LoginInteractorProtocol.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 9/7/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

protocol LoginInteractorInputProtocol: class{
    var presenter: LoginInteractorOutputProtocol? { get set }
    var remoteDataManager: LoginRemoteDataManagerInputProtocol? { get set }
    
    func loginByGoogle(token: String)
    func loginByFacebook(token: String)
    func loginByPhone(_ userLogin: UserLogin)
}

protocol LoginInteractorOutputProtocol: class{
    func didLoginByFacebookSuccess()
    func didLoginByFacebookFail()
    func didLoginByGoogleSuccess()
    func didLoginByGoogleFail()
    func didLoginByPhoneSuccess()
    func didLoginByPhoneFail(_ errorCode: Int)
}
