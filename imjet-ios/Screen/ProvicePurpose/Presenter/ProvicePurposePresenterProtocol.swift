//
//  ProvicePurposePresenterProtocol.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 9/21/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

protocol ProvicePurposePresenterProtocol: class {
    var wireFrame: ProvicePurposeWireFrameProtocol? { get set }
    var interactor: ProvicePurposeInteractorInputProtocol? { get set }
    var view: ProvicePurposeViewProtocol? { get set }
    
    func provicePurpose(_ purpose: UserPurpose)
    func pushSearchAddress(_ builder: JourneyRequestBuilder) // will remove
    func pushJourney(with state: JourneyViewControllerState,_ builder: JourneyRequestBuilder)
    func getProfile()
}
