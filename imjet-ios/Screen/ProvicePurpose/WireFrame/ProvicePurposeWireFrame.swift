//
//  ProvicePurposeWireFrame.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 9/21/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

class ProvicePurposeWireFrame: ProvicePurposeWireFrameProtocol {
    static func createProvicePurposeViewController() -> ProvicePurposeViewController? {
        if let vc = ProvicePurposeViewController.initWithStoryboard() as? ProvicePurposeViewController {
            let wireFrame = ProvicePurposeWireFrame()
            let presenter = ProvicePurposePresenter()
            let interactor = ProvicePurposeInteractor()
            let remoteDataManager = ProvicePurposeRemoteDataManager()
            
            vc.presenter = presenter
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            presenter.view = vc
            interactor.remoteDataManager = remoteDataManager
            interactor.presenter = presenter
            remoteDataManager.remoteRequestHandler = interactor
            
            return vc
        }
        
        return nil
    }
    
    func pushSearchAddress(from view: ProvicePurposeViewProtocol, builder: JourneyRequestBuilder) {
        if let vc = SearchAddressWireFrame.createSearchAddressViewController(builder), let view = view as? ProvicePurposeViewController, let navigationController = view.navigationController {
            navigationController.pushViewController(vc, animated: true)
        }
    }
    
    func pushJourney(from view: ProvicePurposeViewProtocol, with state: JourneyViewControllerState, _ builder: JourneyRequestBuilder) {
        if let vc = JourneyWireFrame.createJourneyViewController(with: state, builder), let view = view as? ProvicePurposeViewController, let navigationController = view.navigationController {
            navigationController.pushViewController(vc, animated: true)
        }
    }
}
