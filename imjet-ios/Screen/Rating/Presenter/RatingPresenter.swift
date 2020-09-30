//
//  RatingPresenter.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 1/2/20.
//  Copyright © 2020 DoanDuyPhuong. All rights reserved.
//

import Foundation

class RatingPresenter: RatingPresenterProtocol {
    weak var view: RatingViewProtocol?
    var interactor: RatingInteractorInputProtocol?
    var wireFrame: RatingWireFrameProtocol?
    
    var journey: Journey?
    
    func ratingJourney(id: Int, rating: Rating) {
        if let interactor = interactor {
            interactor.ratingJourney(id: id, rating: rating)
        }
    }
}

extension RatingPresenter: RatingInteractorOutputProtocol {
    func didRatingJourneySuccess() {
        if let view = view {
            view.didRatingJourneySuccess()
        }
    }
    
    func didRatingJourneyFail() {
        if let view = view {
            view.didRatingJourneyFail()
        }
    }
}
