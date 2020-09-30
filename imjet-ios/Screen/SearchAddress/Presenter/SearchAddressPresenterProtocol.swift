//
//  SearchAddressPresenterProtocol.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 9/1/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import CoreLocation

protocol SearchAddressPresenterProtocol: class {
    var wireFrame: SearchAddressWireFrameProtocol? { get set }
    var view: SearchAddressViewProtocol? { get set }
    var interactor: SearchAddressInteractorInputProtocol? { get set }
    
    func pushChooseAddress(info: GoogleGeocode,_ builder: JourneyRequestBuilder)
    func presentSlideMenu()
    func getDirection(_ startAddress: String,_ endAddress: String)
    func lookUpAddress(location: CLLocation)

}
