//
//  CreateJouneryWireFrameProtocol.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 10/20/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

protocol CreateJouneryWireFrameProtocol: class {
    static func createCreateJouneryViewController(_ extraInfo: [String: AnyObject],_ builder: JourneyRequestBuilder) -> CreateJouneryViewController?
    
    func pushSearchJourney(from view: CreateJouneryViewProtocol,_ builder: JourneyRequestBuilder,_ extraInfo: [String: AnyObject])
    func pushPickUpTime(from view: CreateJouneryViewProtocol,_ builder: JourneyRequestBuilder,_ extraInfo: [String: AnyObject])
}
