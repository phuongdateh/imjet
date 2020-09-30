//
//  RatingInteractor.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 1/2/20.
//  Copyright © 2020 DoanDuyPhuong. All rights reserved.
//

import Foundation

class RatingInteractor: RatingInteractorInputProtocol {
    weak var presenter: RatingInteractorOutputProtocol?
    var remoteDataManager: RatingRemoteDataManagerInputProtocol?
    
    func ratingJourney(id: Int, rating: Rating) {
        if let remoteDataManager = remoteDataManager {
            remoteDataManager.ratingJourney(id: id, rating: rating)
        }
    }
}

extension RatingInteractor: RatingRemoteDataManagerOutputProtocol {
    func didRatingJourneySuccess() {
        if let presenter = presenter {
            presenter.didRatingJourneySuccess()
        }
    }
    
    func didRatingJourneyFail() {
        if let presenter = presenter {
            presenter.didRatingJourneyFail()
        }
    }
}
