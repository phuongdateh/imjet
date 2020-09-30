//
//  ProvicePurposeInteractor.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 9/21/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

class ProvicePurposeInteractor: ProvicePurposeInteractorInputProtocol {
    weak var presenter: ProvicePurposeInteractorOutputProtocol?
    var remoteDataManager: ProvicePurposeRemoteDataManagerInputProtocol?
    
    func provicePurpose(_ purpose: UserPurpose) {
        if let remoteDataManager = remoteDataManager {
            remoteDataManager.provicePurpose(purpose)
        }
    }
    
    func getProfile() {
        if let remoteDataManager = remoteDataManager {
            remoteDataManager.getProfile()
        }
    }
}

extension ProvicePurposeInteractor: ProvicePurposeRemoteDataManagerOutputProtocol {
    func didProvicePurposeSuccess() {
        if let presenter = presenter {
            presenter.didProvicePurposeSuccess()
        }
    }
    
    func didProvicePurposeFail(_ code: Int) {
        if let presenter = presenter {
            presenter.didProvicePurposeFail(code)
        }
    }
}
