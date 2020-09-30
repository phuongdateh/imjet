//
//  RegisterInteractorProtocol.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 9/10/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

protocol RegisterInteractorInputProtocol: class {
    var presenter: RegisterInteractorOutputProtocol? { get set }
    var remoteDataManager: RegisterRemoteDataManagerInputProtocol? { get set }
    
    func sendRequest(_ userRegister: UserRegister)
}

protocol RegisterInteractorOutputProtocol: class {
    func didSendRequestSuccess()
    func didSendRequestFail()
}
