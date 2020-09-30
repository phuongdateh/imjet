//
//  ChooseAddressViewProtocol.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 10/17/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

protocol ChooseAddressViewProtocol: class {
    var presenter: ChooseAddressPresenterProtocol? { get set }
    
    func didLookUpAddressFromStrSuccess(placeList: [GooglePlace])
    func didLookUpAddressFromStrFail()
    func didGetCurrentAddressSuccess(info: GoogleGeocode)
    func didGetCurrentAddressFail()
}
