//
//  JourneyPresenter.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 11/27/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

class JourneyPresenter: JourneyPresenterProtocol {
    weak var view: JourneyViewProtocol?
    var wireFrame: JourneyWireFrameProtocol?
    var interactor: JourneyInteractorInputProtocol?
    
    // MARK: - Navigate screen
    func showPopupHelmet(_ builder: JourneyRequestBuilder) {
        if let wireFrame = wireFrame, let view = view {
            wireFrame.showPopuphelmet(from: view, builder)
        }
    }
    
    func pushJourney(state: JourneyViewControllerState, _ builder: JourneyRequestBuilder,_ extraInfo: [String: AnyObject]) {
        if let wireFrame = wireFrame, let view = view {
            wireFrame.pushJourney(from: view, with: state, builder, extraInfo)
        }
    }
    
    func pushChooseAddress(_ extraInfo: [String : AnyObject], _ builder: JourneyRequestBuilder) {
        if let wireFrame = wireFrame, let view = view {
            wireFrame.pushChooseAddress(from: view, extraInfo, builder)
        }
    }
    
    // MARK: - Data
    func getCurrentAddress() {
        if let interactor = interactor {
            interactor.getCurrentAddress()
        }
    }
    
    func getDirection(query: QueryGoogleModel) {
        if let interactor = interactor {
            interactor.getDirection(query: query)
        }
    }
    
    func getGlobalFee(request: GlobalFeeRequest) {
        if let interactor = interactor {
            interactor.getGlobalFee(request: request)
        }
    }
    
    func createJourney(_ builder: JourneyRequestBuilder) {
        if let interactor = interactor {
            interactor.createJourney(builder)
        }
    }
}

extension JourneyPresenter: JourneyInteractorOutputProtocol{
    // MARK: - CreateJourney
    func didCreateJourneySuccess(_ journey: Journey) {
        if let view = view {
            view.didCreateJourneySuccess(journey)
        }
    }
    
    func didCreateJourneyFail() {
        if let view = view {
            view.didCreateJourneyFail()
        }
    }
    // MARK: - Current Address
    func didGetCurrentAddressSuccess(info: GoogleGeocode) {
        if let view = view {
            view.didGetCurrentAddressSuccess(info: info)
        }
    }
    
    func didGetCurrentAddressFail() {
        if let view = view {
            view.didGetCurrentAddressFail()
        }
    }
    
    // MARK: -Direction
    func didGetDirectionFail() {
        if let view = view {
            view.didGetDirectionFail()
        }
    }
    
    func didGetDirectionSuccess(googleDirection: GoogleDirection) {
        if let view = view {
            view.didGetDirectionSuccess(googleDirection: googleDirection)
        }
    }
    
    // MARK: -Global Fee
    func didGetGlobalFeeSuccess(_ totalFee: Float) {
        if let view = view {
            view.didGetGlobalFeeSuccess(totalFee)
        }
    }
    
    func didGetGlobalFeeFail() {
        if let view = view {
            view.didGetGlobalFeeFail()
        }
    }
}
