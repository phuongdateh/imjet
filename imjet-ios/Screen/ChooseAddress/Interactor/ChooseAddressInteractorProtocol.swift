//
//  ChooseAddressInteractorProtocol.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 10/17/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

protocol ChooseAddressInteractorInputProtocol: class {
    var presenter: ChooseAddressInteractorOutputProtocol? { get set }
    var remoteDataManager: ChooseAddressRemoteDataManagerInputProtocol? { get set }
    
    func lookUpAddressFrom(_ string: String)
    func getCurrentAddress()
}

protocol ChooseAddressInteractorOutputProtocol: class {
    func didLookUpAddressFromStrSuccess(placeList: [GooglePlace])
    func didLookUpAddressFromStrFail()
    func didGetCurrentAddressSuccess(info: GoogleGeocode)
    func didGetCurretnAddressFail()
}
