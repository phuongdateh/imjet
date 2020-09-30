//
//  ProvicePurposeWireFrameProtocol.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 9/21/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

protocol ProvicePurposeWireFrameProtocol: class {
    static func createProvicePurposeViewController() -> ProvicePurposeViewController?
    
    func pushSearchAddress(from view: ProvicePurposeViewProtocol, builder: JourneyRequestBuilder)
    func pushJourney(from view: ProvicePurposeViewProtocol, with state: JourneyViewControllerState, _ builder: JourneyRequestBuilder)
}
