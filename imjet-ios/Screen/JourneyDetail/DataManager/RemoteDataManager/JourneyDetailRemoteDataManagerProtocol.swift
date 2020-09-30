//
//  JourneyDetailRemoteDataManagerProtocol.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 12/25/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

protocol JourneyDetailRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: JourneyDetailRemoteDataManagerOutputProtocol? { get set }
    
    func reloadJourney(_ journeyId: Int)
    func cancelJourney(_ journeyId: Int)
}

protocol JourneyDetailRemoteDataManagerOutputProtocol: class {
    func didReloadJourneySuccess()
    func didReloadJourneyFail()
    func didCancelJourneySuccess()
    func didCancelJourneyFail()
}
