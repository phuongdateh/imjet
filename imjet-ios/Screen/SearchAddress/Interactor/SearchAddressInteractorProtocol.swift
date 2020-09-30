//
//  SearchAddressInteractorProtocol.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 10/2/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import CoreLocation

protocol SearchAddressInteractorInputProtocol: class {
    var presenter: SearchAddressInteractorOutputProtocol? { get set }
    var remoteDataManager: SearchAddressRemoteDataManagerInputProtocol? { get set }
    
    func getDirection(_ startAddress: String,_ endAddress: String)
    func lookUpAddress(location: CLLocation)

}

protocol SearchAddressInteractorOutputProtocol: class {
    func didGetDirectionSuccess()
    func didGetDirectionFail()
    func didLookUpAddressSuccess(info: GoogleGeocode, for coordinate: CLLocationCoordinate2D)
    func didLookUpAddressFail()
}
