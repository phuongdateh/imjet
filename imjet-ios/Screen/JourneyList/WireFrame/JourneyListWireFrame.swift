//
//  OrderListWireFrame.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 11/14/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

class JourneyListWireFrame: JourneyListWireFrameProtocol {
    static func createOrderListViewController() -> JourneyListViewController? {
        if let vc = ViewService.viewController(JourneyListViewController.storyBoardId(), JourneyListViewController.storyBoardName()) as? JourneyListViewController {
            let presenter = JourneyListPresenter()
            let interactor = JourneyListInteractor()
            let wireFrame = JourneyListWireFrame()
            let localDataManager = JourneyListLocalDataManager()
            let remoteDataManager = JourneyListRemoteDataManager()
            
            presenter.view = vc
            presenter.interactor = interactor
            presenter.wireFrame = wireFrame
            interactor.presenter = presenter
            interactor.remoteDataManager = remoteDataManager
            interactor.localDataManager = localDataManager
            remoteDataManager.remoteRequestHandler = interactor
            vc.presenter = presenter
            return vc
        }
        return nil
    }
    
    func pushJourneyDetail(journeyId: Int, from view: JourneyListViewProtocol) {
        if let vc = JourneyDetailWireFrame.createJourneyDetailViewController(journeyId), let view = view as? JourneyListViewController, let navigationController = view.navigationController {
            navigationController.pushViewController(vc, animated: true)
        }
    }
}
