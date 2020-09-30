//
//  SearchAddressInteractor.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 10/2/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import CoreLocation

class SearchAddressInteractor: SearchAddressInteractorInputProtocol {
    weak var presenter: SearchAddressInteractorOutputProtocol?
    var remoteDataManager: SearchAddressRemoteDataManagerInputProtocol?
    
    func getDirection(_ startAddress: String, _ endAddress: String) {
        if let remoteDataManager = remoteDataManager {
            remoteDataManager.getDirecton(startAddress: startAddress, endAddress: endAddress)
        }
    }
    
    func lookUpAddress(location: CLLocation) {
        if let remoteDataManager = remoteDataManager {
            remoteDataManager.lookUpAddress(location: location)
        }
    }

}

extension SearchAddressInteractor: SearchAddressRemoteDataManagerOutputProtocol {
    func didGetDirectionSuccess() {
        
    }
    
    func didGetDirectionFail() {
        
    }
    
    func didLookUpAddressSuccess(info: GoogleGeocode, for coordinate: CLLocationCoordinate2D) {
        if let presenter = presenter {
            presenter.didLookUpAddressSuccess(info: info, for: coordinate)
        }
    }
    
    func didLookUpAddressFail() {
        if let presenter = presenter {
            presenter.didLookUpAddressFail()
        }
    }
}
