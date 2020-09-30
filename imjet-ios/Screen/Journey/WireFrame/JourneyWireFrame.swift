//
//  JourneyWireFrame.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 11/27/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

class JourneyWireFrame: JourneyWireFrameProtocol {
    static func createJourneyViewController(with state: JourneyViewControllerState, _ builder: JourneyRequestBuilder) -> JourneyViewController? {
        if let vc = ViewService.viewController(JourneyViewController.storyBoardId(), JourneyViewController.storyBoardName()) as? JourneyViewController {
            
            let presenter = JourneyPresenter()
            let wireFrame = JourneyWireFrame()
            let interactor = JourneyInteractor()
            let remoteDataManager = JourneyRemoteDataManager()
            
            presenter.wireFrame = wireFrame
            presenter.view = vc
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.remoteDataManager = remoteDataManager
            remoteDataManager.remoteRequestHandler = interactor
            vc.presenter = presenter
            vc.stateViewController = state
            vc.builder = builder
            
            return vc
        }
        return nil
    }
    
    static func createJourneyViewController(with state: JourneyViewControllerState, _ builder: JourneyRequestBuilder, _ extraInfo: [String : AnyObject]) -> JourneyViewController? {
        if let vc = ViewService.viewController(JourneyViewController.storyBoardId(), JourneyViewController.storyBoardName()) as? JourneyViewController {
            
            let presenter = JourneyPresenter()
            let wireFrame = JourneyWireFrame()
            let interactor = JourneyInteractor()
            let remoteDataManager = JourneyRemoteDataManager()
            
            presenter.wireFrame = wireFrame
            presenter.view = vc
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.remoteDataManager = remoteDataManager
            remoteDataManager.remoteRequestHandler = interactor
            vc.presenter = presenter
            vc.stateViewController = state
            vc.builder = builder
            vc.extraInfo = extraInfo
            
            return vc
        }
        return nil
    }
        
    func pushJourney(from view: JourneyViewProtocol, with state: JourneyViewControllerState, _ builder: JourneyRequestBuilder,_ extraInfo: [String: AnyObject]) {
        if let vc = JourneyWireFrame.createJourneyViewController(with: state, builder, extraInfo), let view = view as? JourneyViewController, let navigationController = view.navigationController {
            navigationController.pushViewController(vc, animated: true)
        }
    }
    
    func pushChooseAddress(from view: JourneyViewProtocol, _ extraInfo: [String : AnyObject], _ builder: JourneyRequestBuilder) {
        if let vc = ChooseAddressWireFrame.createChooseAddressViewController(extraInfo: extraInfo, builder), let view = view as? JourneyViewController, let navigationController = view.navigationController {
            navigationController.pushViewController(vc, animated: true)
        }
    }
    
    func showPopuphelmet(from view: JourneyViewProtocol, _ builder: JourneyRequestBuilder) {
        if let vc = PopupHelmetWireFrame.createPopupHelmetViewController(builder), let topMostVC = ViewService.findTopMostViewController(), let view = view as? JourneyViewController {
            vc.delegate = view
            topMostVC.presentOverContext(vc, animated: true, completion: nil)
        }
    }
    
}
