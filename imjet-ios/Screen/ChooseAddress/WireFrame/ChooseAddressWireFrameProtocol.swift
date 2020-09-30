//
//  ChooseAddressWireFrameProtocol.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 10/17/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

protocol ChooseAddressWireFrameProtocol: class {
    static func createChooseAddressViewController(info: GoogleGeocode,_ builder: JourneyRequestBuilder) -> ChooseAddressViewController?
    static func createChooseAddressViewController(extraInfo: [String: AnyObject],_ builder: JourneyRequestBuilder) -> ChooseAddressViewController?
    
    func pushCreateJounery(_ extraInfo: [String: AnyObject],_ builder: JourneyRequestBuilder, from view: ChooseAddressViewProtocol)
    
    func pushJourney(_ extraInfo: [String: AnyObject],_ builder: JourneyRequestBuilder, from view: ChooseAddressViewProtocol)
}
