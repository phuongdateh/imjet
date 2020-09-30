//
//  ChooseAddressWireFrame.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 10/17/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

class ChooseAddressWireFrame: ChooseAddressWireFrameProtocol {
    static func createChooseAddressViewController(info: GoogleGeocode,_ builder: JourneyRequestBuilder) -> ChooseAddressViewController? {
        if let vc = ViewService.viewController(ChooseAddressViewController.storyBoardId(), ChooseAddressViewController.storyBoardName()) as? ChooseAddressViewController {
            let presenter = ChooseAddressPresenter()
            let interactor = ChooseAddressInteractor()
            let wireFrame = ChooseAddressWireFrame()
            let remoteDataManager = ChooseAddressRemoteDataManager()
            
            vc.presenter = presenter
            vc.info = info
            vc.builder = builder
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
    
    static func createChooseAddressViewController(extraInfo: [String : AnyObject], _ builder: JourneyRequestBuilder) -> ChooseAddressViewController? {
        if let vc = ViewService.viewController(ChooseAddressViewController.storyBoardId(), ChooseAddressViewController.storyBoardName()) as? ChooseAddressViewController {
            let presenter = ChooseAddressPresenter()
            let interactor = ChooseAddressInteractor()
            let wireFrame = ChooseAddressWireFrame()
            let remoteDataManager = ChooseAddressRemoteDataManager()
            
            vc.presenter = presenter
            vc.extraInfo = extraInfo
            vc.builder = builder
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
    
    func pushCreateJounery(_ extraInfo: [String: AnyObject], _ builder: JourneyRequestBuilder, from view: ChooseAddressViewProtocol) {
        if let vc = CreateJouneryWireFrame.createCreateJouneryViewController(extraInfo, builder),let view = view as? ChooseAddressViewController, let navigationController = view.navigationController {
            navigationController.pushViewController(vc, animated: true)
        }
    }
    
    func pushJourney(_ extraInfo: [String : AnyObject], _ builder: JourneyRequestBuilder, from view: ChooseAddressViewProtocol) {
        if let vc = JourneyWireFrame.createJourneyViewController(with: .createDepartureTime, builder, extraInfo), let view = view as? ChooseAddressViewController, let navigationController = view.navigationController {
            navigationController.pushViewController(vc, animated: true)
        }
    }
}
