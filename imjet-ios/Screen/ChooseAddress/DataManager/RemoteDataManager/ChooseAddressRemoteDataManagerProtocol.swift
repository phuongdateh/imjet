//
//  ChooseAddressRemoteDataManagerProtocol.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 10/17/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

protocol ChooseAddressRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: ChooseAddressRemoteDataManagerOutputProtocol? { get set }
    
    func getAutocomple(string: String)
    func getCurrentAddress()
}

protocol ChooseAddressRemoteDataManagerOutputProtocol: class {
    func didLookUpAddressFromStrSuccess(placeList: [GooglePlace])
    func didLookUpAddressFromStrFail()
    func didGetCurrentAddressSuccess(info: GoogleGeocode)
    func didGetCurrentAddressFail()
}
