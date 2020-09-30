//
//  LoginRemoteDataManager.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 9/7/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

protocol LoginRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: LoginRemoteDataManagerOutputProtocol? { get set }
    
    func loginByFacebook(token: String)
    func loginByGoogle(token: String)
    func loginByPhone(_ userLogin: UserLogin)
}

protocol LoginRemoteDataManagerOutputProtocol: class {
    func didLoginByFacebookSuccess()
    func didLoginByFacebookFail()
    func didLoginByGoogleSuccess()
    func didLoginByGoogleFail()
    func didLoginByPhoneSuccess()
    func didLoginByPhoneFail(_ errorCode: Int)
}
