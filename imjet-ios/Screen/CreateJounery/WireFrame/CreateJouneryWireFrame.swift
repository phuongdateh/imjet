//
//  CreateJouneryWireFrame.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 10/20/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

class CreateJouneryWireFrame: CreateJouneryWireFrameProtocol {
    static func createCreateJouneryViewController(_ extraInfo: [String: AnyObject], _ builder: JourneyRequestBuilder) -> CreateJouneryViewController? {
        if let vc = ViewService.viewController(CreateJouneryViewController.storyBoardId(), CreateJouneryViewController.storyBoardName()) as? CreateJouneryViewController {
            let wireFrame = CreateJouneryWireFrame()
            let presenter = CreateJouneryPresenter()
            let interactor = CreateJouneryInteractor()
            let remoteDataManager = CreateJouneryRemoteDataManager()
            
            presenter.view = vc
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.remoteDataManager = remoteDataManager
            remoteDataManager.remoteRequestHandler = interactor
            vc.presenter = presenter
            vc.extraInfo = extraInfo
            vc.builder = builder
            
            return vc
        }
        return nil
    }
    
    func pushSearchJourney(from view: CreateJouneryViewProtocol, _ builder: JourneyRequestBuilder,_ extraInfo: [String: AnyObject]) {
        if let vc = SearchJourneyWireFrame.createSearchJourneyViewController(builder,extraInfo), let view = view as? CreateJouneryViewController, let navigationController = view.navigationController {
            navigationController.pushViewController(vc, animated: true)
        }
    }
    
    func pushPickUpTime(from view: CreateJouneryViewProtocol, _ builder: JourneyRequestBuilder, _ extraInfo: [String : AnyObject]) {
        if let vc = PickUpTimeWireFrame.createPickUpTimeViewController(extraInfo, builder), let view = view as? CreateJouneryViewController, let navigationController = view.navigationController {
            navigationController.pushViewController(vc, animated: true)
        }
    }
}
