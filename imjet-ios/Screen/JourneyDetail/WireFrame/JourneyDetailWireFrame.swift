//
//  JourneyDetailWireFrame.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 12/25/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

class JourneyDetailWireFrame: JourneyDetailWireFrameProtocol {
    static func createJourneyDetailViewController(_ journeyId: Int) -> JourneyDetailViewController? {
        if let vc = ViewService.viewController(JourneyDetailViewController.storyBoardId(), JourneyDetailViewController.storyBoardName()) as? JourneyDetailViewController {
            let presenter = JourneyDetailPresenter()
            let wireFrame = JourneyDetailWireFrame()
            let interactor = JourneyDetailInteractor()
            let remoteDataManager = JourneyDetailRemoteDataManager()
            let localDataManager = JourneyDetailLocalDataManager()
            
            vc.presenter = presenter
            presenter.interactor = interactor
            presenter.wireFrame = wireFrame
            presenter.view = vc
            presenter.journeyId = journeyId
            interactor.presenter = presenter
            interactor.remoteDataManager = remoteDataManager
            interactor.localDataManager = localDataManager
            remoteDataManager.remoteRequestHandler = interactor
            
            return vc
        }
        return nil
    }
    
    func pushRating(from view: JourneyDetailViewProtocol, _ journey: Journey) {
        if let vc = RatingWireFrame.createRatingViewController(journey: journey), let view = view as? JourneyDetailViewController, let navigationController = view.navigationController {
            navigationController.pushViewController(vc, animated: true)
        }
    }
}
