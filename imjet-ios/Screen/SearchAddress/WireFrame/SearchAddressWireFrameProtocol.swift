//
//  SearchAddressWireFrameProtocol.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 8/27/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

protocol SearchAddressWireFrameProtocol: class {
    static func createSearchAddressViewController(_ builder: JourneyRequestBuilder) -> SearchAddressViewController?
    static func createSearchAddressViewController() -> SearchAddressViewController?
    
    func presentSlideMenu(from view: SearchAddressViewProtocol)
    func pushChooseAddress(from view: SearchAddressViewProtocol, info: GoogleGeocode,_ builder: JourneyRequestBuilder)
}
