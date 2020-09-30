//
//  RatingRemoteDataManager.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 1/2/20.
//  Copyright © 2020 DoanDuyPhuong. All rights reserved.
//

import Foundation

class RatingRemoteDataManager: RatingRemoteDataManagerInputProtocol {
    weak var remoteRequestHandler: RatingRemoteDataManagerOutputProtocol?
        
    func ratingJourney(id: Int, rating: Rating) {
        APIServiceManager.sharedInstance.ratingJourney(journeyId: id, rating: rating) { [weak self] (errorPackage, responsePackage) in
            if let _ = errorPackage {
                if let weakSelf = self, let remoteRequestHandler = weakSelf.remoteRequestHandler {
                    remoteRequestHandler.didRatingJourneyFail()
                    return
                }
            }
            else if let responsePackage = responsePackage,
                let value = responsePackage.value as? [String: AnyObject],
                let data = value[Constants.kData] as? [String: AnyObject] {
                Log.debug(data)
                if let weakSelf = self, let remoteRequestHandler = weakSelf.remoteRequestHandler {
                    remoteRequestHandler.didRatingJourneySuccess()
                    return
                }
            }
        }
    }
}
