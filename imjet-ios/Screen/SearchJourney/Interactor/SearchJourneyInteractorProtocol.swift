//
//  SearchJourneyInteractorProtocol.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 10/26/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

protocol SearchJourneyInteractorInputProtocol: class {
    var presenter: SearchJourneyInteractorOutputProtocol? { get set }
    var remoteDataManager: SearchJourneyRemoteDataManagerInputProtocol? { get set }
    
    func createJourney(_ builder: JourneyRequestBuilder)
    func getGlobalFee(_ globalRequest: GlobalFeeRequest)
}

protocol SearchJourneyInteractorOutputProtocol: class {
    func didCreateJourneySuccess(_ journey: Journey)
    func didCreateJourneyFail()
    func didGetGlobalFeeSuccess(_ totalFee: Float)
    func didGetGlobalFeeFail()
}
