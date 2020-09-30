//
//  SearchAddressRemoteDataManagerProtocol.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 10/2/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import CoreLocation

protocol SearchAddressRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: SearchAddressRemoteDataManagerOutputProtocol? { get set }
    
    func getDirecton(startAddress: String, endAddress: String)
    func lookUpAddress(location: CLLocation)
}

protocol SearchAddressRemoteDataManagerOutputProtocol: class {
    func didGetDirectionSuccess()
    func didGetDirectionFail()
    func didLookUpAddressSuccess(info: GoogleGeocode, for coordinate: CLLocationCoordinate2D)
    func didLookUpAddressFail()
}
