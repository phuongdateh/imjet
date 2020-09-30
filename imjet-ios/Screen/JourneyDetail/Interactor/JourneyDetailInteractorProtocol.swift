//
//  JourneyDetailInteractorProtocol.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 12/25/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import RealmSwift

protocol JourneyDetailInteractorInputProtocol: class {
    var presenter: JourneyDetailInteractorOutputProtocol? { get set }
    var remoteDataManager: JourneyDetailRemoteDataManagerInputProtocol? { get set }
    var localDataManager: JourneyDetailLocalDataManagerProtocol? { get set }
    
    func initJourney(journeyId: Int)
    func reloadJourney(with journeyId: Int)
    func registerChange(journey: Journey)
    func cancelJourney(_ journeyId: Int)
}

protocol JourneyDetailInteractorOutputProtocol: class {
    func didInitJourney(_ journey: Journey?)
    func didReloadJourneySuccess()
    func didReloadJourneyFaild()
    func didReceiveChagne(journeyChange: ObjectChange)
    func didCancelJourneySuccess()
    func didCancelJourneyFail()
}
