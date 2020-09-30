//
//  SearchAddressPresenter.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 9/1/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import CoreLocation

class SearchAddressPresenter: SearchAddressPresenterProtocol {
    weak var view: SearchAddressViewProtocol?
    var wireFrame: SearchAddressWireFrameProtocol?
    var interactor: SearchAddressInteractorInputProtocol?
    
    func pushChooseAddress(info: GoogleGeocode,_ builder: JourneyRequestBuilder) {
        if let wireFrame = wireFrame, let view = view {
            wireFrame.pushChooseAddress(from: view, info: info, builder)
        }
    }
    
    func presentSlideMenu() {
        if let wireFrame = wireFrame, let view = view {
            wireFrame.presentSlideMenu(from: view)
        }
    }
    
    func getDirection(_ startAddress: String, _ endAddress: String) {
        if let interactor = interactor {
            interactor.getDirection(startAddress, endAddress)
        }
    }
    
    func lookUpAddress(location: CLLocation) {
        if let interactor = interactor {
            interactor.lookUpAddress(location: location)
        }
    }

}

extension SearchAddressPresenter: SearchAddressInteractorOutputProtocol {
    func didGetDirectionSuccess() {
        
    }
    
    func didGetDirectionFail() {
        
    }
    
    func didLookUpAddressSuccess(info: GoogleGeocode, for coordinate: CLLocationCoordinate2D) {
        if let view = view {
            view.didLookUpAddressSuccess(info: info, for: coordinate)
        }
    }
    
    func didLookUpAddressFail() {
        if let view = view {
            view.didLookUpAddressFail()
        }
    }
}
