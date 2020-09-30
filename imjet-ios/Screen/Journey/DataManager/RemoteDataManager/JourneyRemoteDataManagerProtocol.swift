//
//  JourneyRemoteDataManagerProtocol.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 12/7/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

protocol JourneyRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: JourneyRemoteDataManagerOutputProtocol? { get set }
    
    func getCurrentAddress()
    func getDirection(_ info: QueryGoogleModel)
    func getGlobalFee(_ request: GlobalFeeRequest)
    func createJourney(_ builder: JourneyRequestBuilder)
}

protocol JourneyRemoteDataManagerOutputProtocol: class {
    func didGetCurrentAddressSuccess(info: GoogleGeocode)
    func didGetCurrentAddressFail()
    func didGetDirectionFail()
    func didGetDirectionSuccess(googleDirection: GoogleDirection)
    func didGetGlobalFeeSuccess(_ totalFee: Float)
    func didGetGlobalFeeFail()
    func didCreateJourneySuccess(_ journey: Journey)
    func didCreateJourneyFail()
}
