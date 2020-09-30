//
//  RegisterRemoteDataManagerInputProtocol.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 9/10/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

protocol RegisterRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: RegisterRemoteDataManagerOutputProtocol? { get set }
    
    func sendRequest(_ userRegister: UserRegister)
}

protocol RegisterRemoteDataManagerOutputProtocol: class {
    func didSendRequestSuccess()
    func didSendRequestFail()
}
