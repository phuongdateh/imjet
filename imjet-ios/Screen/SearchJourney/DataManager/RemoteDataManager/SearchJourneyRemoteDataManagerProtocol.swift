//
//  SearchJourneyRemoteDataManagerProtocol.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 10/26/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

protocol SearchJourneyRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: SearchJourneyRemoteDataManagerOutputProtocol? { get set }
    
    func createJourney(_ builder: JourneyRequestBuilder)
    func getGlobalFee(_ globalRequest: GlobalFeeRequest)
}

protocol SearchJourneyRemoteDataManagerOutputProtocol: class {
    func didGetGlobalFeeSuccess(_ totalFee: Float)
    func didGetGlobalFeeFail()
    func didCreateJourneySuccess(_ journey: Journey)
    func didCreateJourneyFail()
}
