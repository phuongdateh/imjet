//
//  RatingWireFrame.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 1/2/20.
//  Copyright © 2020 DoanDuyPhuong. All rights reserved.
//

import Foundation

class RatingWireFrame: RatingWireFrameProtocol {
    static func createRatingViewController(journey: Journey) -> RatingViewController? {
        if let vc = ViewService.viewController(RatingViewController.storyBoardId(), RatingViewController.storyBoardName()) as? RatingViewController {
            
            let presenter = RatingPresenter()
            let interactor = RatingInteractor()
            let wireFrame = RatingWireFrame()
            let remoteDataManager = RatingRemoteDataManager()
            
            vc.presenter = presenter
            presenter.journey = journey
            presenter.view = vc
            presenter.interactor = interactor
            presenter.wireFrame = wireFrame
            interactor.presenter = presenter
            interactor.remoteDataManager = remoteDataManager
            remoteDataManager.remoteRequestHandler = interactor
            
            return vc
        }
        return nil
    }
}
