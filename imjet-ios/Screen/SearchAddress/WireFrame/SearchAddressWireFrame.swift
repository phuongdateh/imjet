//
//  SearchAddressWireFrame.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 8/27/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import UIKit

class SearchAddressWireFrame: SearchAddressWireFrameProtocol {
    static func createSearchAddressViewController(_ builder: JourneyRequestBuilder) -> SearchAddressViewController? {
        if let vc = SearchAddressViewController.initWithStoryboard() as? SearchAddressViewController {
            let presenter = SearchAddressPresenter()
            let wireFrame = SearchAddressWireFrame()
            let interactor = SearchAddressInteractor()
            let remoteDataManager = SearchAddressRemoteDataManager()
            
            vc.builder = builder
            vc.presenter = presenter
            presenter.wireFrame = wireFrame
            presenter.view = vc
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.remoteDataManager = remoteDataManager
            remoteDataManager.remoteRequestHandler = interactor
            
            return vc
        }
        return nil
    }
    
    static func createSearchAddressViewController() -> SearchAddressViewController? {
        if let vc = SearchAddressViewController.initWithStoryboard() as? SearchAddressViewController {
            let presenter = SearchAddressPresenter()
            let wireFrame = SearchAddressWireFrame()
            let interactor = SearchAddressInteractor()
            let remoteDataManager = SearchAddressRemoteDataManager()
            let buidler = JourneyRequestBuilder.init(userPurpose: "helmet_user")
            
            vc.builder = buidler
            vc.presenter = presenter
            presenter.wireFrame = wireFrame
            presenter.view = vc
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.remoteDataManager = remoteDataManager
            remoteDataManager.remoteRequestHandler = interactor
            
            return vc
        }
        return nil
    }
    
    func presentSlideMenu(from view: SearchAddressViewProtocol) {
        if let topMostVC = ViewService.findTopMostViewController(), let vc = SlideMenuWireFrame.createSlideMenuViewController() {
            let navigationController = UINavigationController.init(rootViewController: vc)
            topMostVC.presentOverContext(navigationController, animated: true, completion: nil)
        }
    }
    
    func pushChooseAddress(from view: SearchAddressViewProtocol, info: GoogleGeocode,_ builder: JourneyRequestBuilder) {
        if let vc = ChooseAddressWireFrame.createChooseAddressViewController(info: info, builder), let view = view as? SearchAddressViewController, let navigationController = view.navigationController {
            navigationController.pushViewController(vc, animated: true)
        }
    }
}
