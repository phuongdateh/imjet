//
//  RatingRemoteDataManagerProtocol.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 1/2/20.
//  Copyright © 2020 DoanDuyPhuong. All rights reserved.
//

import Foundation

protocol RatingRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: RatingRemoteDataManagerOutputProtocol? { get set }
    
    func ratingJourney(id: Int, rating: Rating)
}

protocol RatingRemoteDataManagerOutputProtocol: class {
    func didRatingJourneySuccess()
    func didRatingJourneyFail()
}
