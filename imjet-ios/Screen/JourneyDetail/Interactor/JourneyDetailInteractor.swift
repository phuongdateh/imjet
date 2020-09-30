//
//  JourneyDetailInteractor.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 12/25/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import RealmSwift

class JourneyDetailInteractor: JourneyDetailInteractorInputProtocol {
    weak var presenter: JourneyDetailInteractorOutputProtocol?
    var remoteDataManager: JourneyDetailRemoteDataManagerInputProtocol?
    var localDataManager: JourneyDetailLocalDataManagerProtocol?
    
    private var journeyNotificationToken: NotificationToken?
    
    func initJourney(journeyId: Int) {
        if let localDataManager = localDataManager,
            let presenter = presenter  {
            presenter.didInitJourney(localDataManager.initJourney(journeyId: journeyId))
        }
    }
    
    func reloadJourney(with journeyId: Int) {
        if let remoteDataManager = remoteDataManager {
            remoteDataManager.reloadJourney(journeyId)
        }
    }
    
    func cancelJourney(_ journeyId: Int) {
        if let remoteDataManager = remoteDataManager {
            remoteDataManager.cancelJourney(journeyId)
        }
    }
    
    deinit {
        if let journeyNotificationToken = journeyNotificationToken {
            journeyNotificationToken.invalidate()
        }
    }
    
    func registerChange(journey: Journey) {
        journeyNotificationToken = journey.observe({[weak self] (change) in
            if let weakSelf = self, let presenter = weakSelf.presenter {
                presenter.didReceiveChagne(journeyChange: change)
            }
        })
    }
}

extension JourneyDetailInteractor: JourneyDetailRemoteDataManagerOutputProtocol {
    // MARK: - DidReloadJoruney
    func didReloadJourneySuccess() {
        if let presenter = presenter {
            presenter.didReloadJourneySuccess()
        }
    }
    
    func didReloadJourneyFail() {
        if let presenter = presenter {
            presenter.didReloadJourneyFaild()
        }
    }
    
    // MARK: - DidCancelJourney
    func didCancelJourneySuccess() {
        if let presenter = presenter {
            presenter.didCancelJourneySuccess()
        }
    }
    
    func didCancelJourneyFail() {
        if let presenter = presenter {
            presenter.didCancelJourneyFail()
        }
    }
}
