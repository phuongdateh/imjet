//
//  RegisterInteractor.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 9/10/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

class RegisterInteractor: RegisterInteractorInputProtocol {
    weak var presenter: RegisterInteractorOutputProtocol?
    var remoteDataManager: RegisterRemoteDataManagerInputProtocol?
    
    func sendRequest(_ userRegister: UserRegister) {
        if let remoteDataManager = remoteDataManager {
            remoteDataManager.sendRequest(userRegister)
        }
    }
}

extension RegisterInteractor: RegisterRemoteDataManagerOutputProtocol {
    func didSendRequestSuccess() {
        if let presenter = presenter {
            presenter.didSendRequestSuccess()
        }
    }
    
    func didSendRequestFail() {
        if let presenter = presenter {
            presenter.didSendRequestFail()
        }
    }
}
