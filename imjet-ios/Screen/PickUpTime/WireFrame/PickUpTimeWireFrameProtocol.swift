//
//  PickUpTimeWireFrameProtocol.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 11/4/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

protocol PickUpTimeWireFrameProtocol: class {
    static func createPickUpTimeViewController(_ extraInfo: [String: AnyObject],_ builder: JourneyRequestBuilder) -> PickUpTimeViewController?
    
    func pushSearchJourney(from view: PickUpTimeViewProtocol,_ extraInfo: [String: AnyObject],_ builder: JourneyRequestBuilder)
}
