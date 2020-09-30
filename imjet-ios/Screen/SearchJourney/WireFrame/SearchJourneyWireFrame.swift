//
//  SearchJourneyWireFrame.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 10/26/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

class SearchJourneyWireFrame: SearchJourneyWireFrameProtocol {
    static func createSearchJourneyViewController(_ builder: JourneyRequestBuilder,_ extraInfo: [String: AnyObject]) -> SearchJourneyViewController? {
        if let vc = SearchJourneyViewController.initWithStoryboard() as? SearchJourneyViewController {
            let presenter = SearchJourneyPresenter()
            let interactor = SearchJourneyInteractor()
            let wireFrame = SearchJourneyWireFrame()
            let remoteDataManager = SearchJourneyRemoteDataManager()
            
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
}
