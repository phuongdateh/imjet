//
//  JourneyDetailPresenter.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 12/25/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import RealmSwift

class JourneyDetailPresenter: JourneyDetailPresenterProtocol {
    weak var view: JourneyDetailViewProtocol?
    var interactor: JourneyDetailInteractorInputProtocol?
    var wireFrame: JourneyDetailWireFrameProtocol?
    
    var journey: Journey?
    var journeyId: Int?
    
    func viewDidLoad() {
        if let journeyId = journeyId, let interactor = interactor {
            interactor.initJourney(journeyId: journeyId)
        }
        if let view = view {
            view.beginLoading()
        }
    }
    
    func reloadData() {
        if let interactor = interactor, let journeyId = journeyId {
            interactor.reloadJourney(with: journeyId)
        }
    }
    
    func cancelJourney(_ journeyId: Int) {
        if let interactor = interactor {
            interactor.cancelJourney(journeyId)
        }
    }
    
    func pushRating(_ journey: Journey) {
        if let wireFrame = wireFrame, let view = view {
            wireFrame.pushRating(from: view, journey)
        }
    }
}

extension JourneyDetailPresenter: JourneyDetailInteractorOutputProtocol {
    
    // MARK: - Receive Change Journey
    func didReceiveChagne(journeyChange: ObjectChange) {
        if let view = view {
            view.updateView()
        }
    }

    // MARK: - DidInitJourney
    func didInitJourney(_ journey: Journey?) {
        self.journey = journey
        if let journey = self.journey {
            if let interactor = interactor {
                interactor.registerChange(journey: journey)
            }
        }
        
        if let view = view {
            view.updateView()
        }
    }
    
    // MARK: - DidReloadJourney
    func didReloadJourneySuccess() {
        if let view = view {
            view.stopLoading()
        }
    }
    
    func didReloadJourneyFaild() {
        if let view = view {
            view.stopLoading()
        }
    }
    
    // MARK: - DidCancel Journey
    func didCancelJourneySuccess() {
        if let view = view {
            view.didCancelJourneySuccess()
        }
    }
    
    func didCancelJourneyFail() {
        if let view = view {
            view.didCancelJourneyFail()
        }
    }
}
