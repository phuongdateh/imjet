//
//  JourneyInteractorProtocol.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 12/7/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

protocol JourneyInteractorInputProtocol: class {
    var presenter: JourneyInteractorOutputProtocol? { get set }
    var remoteDataManager: JourneyRemoteDataManagerInputProtocol? { get set }
    
    func getCurrentAddress()
    func getDirection(query: QueryGoogleModel)
    func getGlobalFee(request: GlobalFeeRequest)
    func createJourney(_ builder: JourneyRequestBuilder)
}

protocol JourneyInteractorOutputProtocol: class {
    func didGetCurrentAddressSuccess(info: GoogleGeocode)
    func didGetCurrentAddressFail()
    func didGetDirectionFail()
    func didGetDirectionSuccess(googleDirection: GoogleDirection)
    func didGetGlobalFeeSuccess(_ totalFee: Float)
    func didGetGlobalFeeFail()
    func didCreateJourneySuccess(_ journey: Journey)
    func didCreateJourneyFail()
}
