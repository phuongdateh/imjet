//
//  RatingInteractorProtocol.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 1/2/20.
//  Copyright © 2020 DoanDuyPhuong. All rights reserved.
//

import Foundation

protocol RatingInteractorInputProtocol: class {
    var presenter: RatingInteractorOutputProtocol? { get set }
    var remoteDataManager: RatingRemoteDataManagerInputProtocol? { get set }
    
    func ratingJourney(id: Int, rating: Rating)
}

protocol RatingInteractorOutputProtocol: class {
    func didRatingJourneySuccess()
    func didRatingJourneyFail()
}
