//
//  ChooseAddressInteractor.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 10/17/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

class ChooseAddressInteractor: ChooseAddressInteractorInputProtocol {
    weak var presenter: ChooseAddressInteractorOutputProtocol?
    var remoteDataManager: ChooseAddressRemoteDataManagerInputProtocol?
    
    func lookUpAddressFrom(_ string: String) {
        if let remoteDataManager = remoteDataManager {
            remoteDataManager.getAutocomple(string: string)
        }
    }
    
    func getCurrentAddress() {
        if let remoteDataManager = remoteDataManager {
            remoteDataManager.getCurrentAddress()
        }
    }
}

extension ChooseAddressInteractor: ChooseAddressRemoteDataManagerOutputProtocol {
    func didLookUpAddressFromStrSuccess(placeList: [GooglePlace]) {
        if let presenter = presenter {
            presenter.didLookUpAddressFromStrSuccess(placeList: placeList)
        }
    }
    
    func didLookUpAddressFromStrFail() {
        if let presenter = presenter {
            presenter.didLookUpAddressFromStrFail()
        }
    }
    
    func didGetCurrentAddressSuccess(info: GoogleGeocode) {
        if let presenter = presenter {
            presenter.didGetCurrentAddressSuccess(info: info)
        }
    }
    
    func didGetCurrentAddressFail() {
        if let presenter = presenter {
            presenter.didGetCurretnAddressFail()
        }
    }
    
}
