//
//  SearchAddressViewProtocol.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 9/1/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import CoreLocation

protocol SearchAddressViewProtocol: class {
    var presenter: SearchAddressPresenterProtocol? { get set }
    
    func didGetDirectionSuccess()
    func didGetDirectionFail()
    func didLookUpAddressSuccess(info: GoogleGeocode, for coordinate: CLLocationCoordinate2D)
    func didLookUpAddressFail()
}
