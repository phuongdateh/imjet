//
//  JourneyPresenterProtocol.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 11/27/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

protocol JourneyPresenterProtocol: class {
    var view: JourneyViewProtocol? { get set }
    var wireFrame: JourneyWireFrameProtocol? { get set }
    var interactor: JourneyInteractorInputProtocol? { get set }
    
    // MARK: - Navigate Screen
    func pushJourney(state: JourneyViewControllerState,_ builder: JourneyRequestBuilder,_ extraInfo: [String: AnyObject])
    func pushChooseAddress(_ extraInfo: [String: AnyObject],_ builder: JourneyRequestBuilder)
    func showPopupHelmet(_ builder: JourneyRequestBuilder)
    
    // MARK: - Data
    func getCurrentAddress()
    func getDirection(query: QueryGoogleModel)
    func getGlobalFee(request: GlobalFeeRequest)
    func createJourney(_ builder: JourneyRequestBuilder)
}
