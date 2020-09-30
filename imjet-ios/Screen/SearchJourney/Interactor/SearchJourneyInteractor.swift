//
//  SearchJourneyInteractor.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 10/26/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

class SearchJourneyInteractor: SearchJourneyInteractorInputProtocol {
    weak var presenter: SearchJourneyInteractorOutputProtocol?
    var remoteDataManager: SearchJourneyRemoteDataManagerInputProtocol?
    
    func createJourney(_ builder: JourneyRequestBuilder) {
        if let remoteDataManager = remoteDataManager {
            remoteDataManager.createJourney(builder)
        }
    }
    
    func getGlobalFee(_ globalRequest: GlobalFeeRequest) {
        if let remoteDataManager = remoteDataManager {
            remoteDataManager.getGlobalFee(globalRequest)
        }
    }
}

extension SearchJourneyInteractor: SearchJourneyRemoteDataManagerOutputProtocol {
    func didGetGlobalFeeSuccess(_ totalFee: Float) {
        if let presenter = presenter {
            presenter.didGetGlobalFeeSuccess(totalFee)
        }
    }
    
    func didGetGlobalFeeFail() {
        if let presenter = presenter {
            presenter.didGetGlobalFeeFail()
        }
    }
    
    func didCreateJourneySuccess(_ journey: Journey) {
        if let presenter = presenter {
            presenter.didCreateJourneySuccess(journey)
        }
    }
    
    func didCreateJourneyFail() {
        if let presenter = presenter {
            presenter.didCreateJourneyFail()
        }
    }
}
