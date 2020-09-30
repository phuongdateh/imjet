//
//  JourneyWireFrameProtocol.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 11/27/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

protocol JourneyWireFrameProtocol: class {
    static func createJourneyViewController(with state: JourneyViewControllerState,_ builder: JourneyRequestBuilder) -> JourneyViewController?
    static func createJourneyViewController(with state: JourneyViewControllerState,_ builder: JourneyRequestBuilder,_ extraInfo: [String: AnyObject]) -> JourneyViewController?
    
    func pushJourney(from view: JourneyViewProtocol,with state: JourneyViewControllerState,_ builder: JourneyRequestBuilder,_ extraInfo: [String: AnyObject])
    func pushChooseAddress(from view: JourneyViewProtocol,_ extraInfo: [String: AnyObject],_ builder: JourneyRequestBuilder)
    func showPopuphelmet(from view: JourneyViewProtocol,_ builder: JourneyRequestBuilder)
}
