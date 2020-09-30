//
//  CreateJouneryInteractor.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 10/20/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

class CreateJouneryInteractor: CreateJouneryInteractorInputProtocol {
    weak var presenter: CreateJouneryInteractorOutputProtocol?
    var remoteDataManager: CreateJouneryRemoteDataManagerInputProtocol?
    
    func getDirection(_ info: QueryGoogleModel) {
        if let remoteDataManager = remoteDataManager {
            remoteDataManager.getDirection(info)
        }
    }
}

extension CreateJouneryInteractor: CreateJouneryRemoteDataManagerOutputProtocol {
    func didGetDirectionSuccess(_ infoDirection: GoogleDirection) {
        if let presenter = presenter {
            presenter.didGetDirectionSuccess(infoDirection)
        }
    }
    
    func didGetDirectionFail() {
        if let presenter = presenter {
            presenter.didGetDirectionFail()
        }
    }
}
