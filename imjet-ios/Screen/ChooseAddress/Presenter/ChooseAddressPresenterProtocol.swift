//
//  ChooseAddressPresenterProtocol.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 10/17/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

protocol ChooseAddressPresenterProtocol: class {
    var wireFrame: ChooseAddressWireFrameProtocol? { get set }
    var interactor: ChooseAddressInteractorInputProtocol? { get set }
    var view: ChooseAddressViewProtocol? { get set }
    
    func lookUpAddressFrom(_ string: String)
    func pushCreateJourney(_ extraInfo: [String: AnyObject],_ builder: JourneyRequestBuilder) // will remove
    func pushJourney(_ extraInfo: [String: AnyObject], _ builder: JourneyRequestBuilder)
    func getCurrentAddress()
}
