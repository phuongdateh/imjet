//
//  JourneyInteractor.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 12/7/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

class JourneyInteractor: JourneyInteractorInputProtocol {
    weak var presenter: JourneyInteractorOutputProtocol?
    var remoteDataManager: JourneyRemoteDataManagerInputProtocol?
    
    func getCurrentAddress() {
        if let remoteDataManager = remoteDataManager {
            remoteDataManager.getCurrentAddress()
        }
    }
    
    func getDirection(query: QueryGoogleModel) {
        if let remoteDataManager = remoteDataManager {
            remoteDataManager.getDirection(query)
        }
    }
    
    func getGlobalFee(request: GlobalFeeRequest) {
        if let remoteDataManager = remoteDataManager {
            remoteDataManager.getGlobalFee(request)
        }
    }
    
    func createJourney(_ builder: JourneyRequestBuilder) {
        if let remoteDataManager = remoteDataManager {
            remoteDataManager.createJourney(builder)
        }
    }
}

extension JourneyInteractor: JourneyRemoteDataManagerOutputProtocol {
    // MARK: - CreateJourney
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
    
    // MARK: - Direction
    func didGetDirectionFail() {
        if let presenter = presenter {
            presenter.didGetDirectionFail()
        }
    }
    
    func didGetDirectionSuccess(googleDirection: GoogleDirection) {
        if let presenter = presenter {
            presenter.didGetDirectionSuccess(googleDirection: googleDirection)
        }
    }
    
    // MARK:- Current Address
    func didGetCurrentAddressSuccess(info: GoogleGeocode) {
        if let presenter = presenter {
            presenter.didGetCurrentAddressSuccess(info: info)
        }
    }
    
    func didGetCurrentAddressFail() {
        if let presenter = presenter {
            presenter.didGetCurrentAddressFail()
        }
    }
    
    // MARK: - Global Fee
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
}
