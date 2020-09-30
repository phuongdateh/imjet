//
//  SearchJourneyPresenter.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 10/26/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

class SearchJourneyPresenter: SearchJourneyPresenterProtocol {
    weak var view: SearchJourneyViewProtocol?
    var interactor: SearchJourneyInteractorInputProtocol?
    var wireFrame: SearchJourneyWireFrameProtocol?
    
    func createJourney(_ builder: JourneyRequestBuilder) {
        if let interactor = interactor {
            interactor.createJourney(builder)
        }
    }
    
    func getGlobalFee(_ globalRequest: GlobalFeeRequest) {
        if let interactor = interactor {
            interactor.getGlobalFee(globalRequest)
        }
    }
    
}

extension SearchJourneyPresenter: SearchJourneyInteractorOutputProtocol {
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
}
