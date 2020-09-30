//
//  ChooseAddressPresenter.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 10/17/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

class ChooseAddressPresenter: ChooseAddressPresenterProtocol {
    weak var view: ChooseAddressViewProtocol?
    var interactor: ChooseAddressInteractorInputProtocol?
    var wireFrame: ChooseAddressWireFrameProtocol?
    
    func lookUpAddressFrom(_ string: String) {
        if let interactor = interactor {
            interactor.lookUpAddressFrom(string)
        }
    }
    
    func pushCreateJourney(_ extraInfo: [String: AnyObject], _ builder: JourneyRequestBuilder) {
        if let wireFrame = wireFrame, let view = view {
            wireFrame.pushCreateJounery(extraInfo, builder, from: view)
        }
    }
    
    func pushJourney(_ extraInfo: [String : AnyObject], _ builder: JourneyRequestBuilder) {
        if let wireFrame = wireFrame, let view = view {
            wireFrame.pushJourney(extraInfo, builder, from: view)
        }
    }
    
    func getCurrentAddress() {
        if let interactor = interactor {
            interactor.getCurrentAddress()
        }
    }
}

extension ChooseAddressPresenter: ChooseAddressInteractorOutputProtocol {
    func didLookUpAddressFromStrSuccess(placeList: [GooglePlace]) {
        if let view = view {
            view.didLookUpAddressFromStrSuccess(placeList: placeList)
        }
    }
    
    func didLookUpAddressFromStrFail() {
        if let view = view {
            view.didLookUpAddressFromStrFail()
        }
    }
    
    func didGetCurrentAddressSuccess(info: GoogleGeocode) {
        if let view = view {
            view.didGetCurrentAddressSuccess(info: info)
        }
    }
    
    func didGetCurretnAddressFail() {
        if let view = view {
            view.didGetCurrentAddressFail()
        }
    }
}
