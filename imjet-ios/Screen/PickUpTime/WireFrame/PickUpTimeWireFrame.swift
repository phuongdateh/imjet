//
//  PickUpTimeWireFrame.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 11/4/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

class PickUpTimeWireFrame: PickUpTimeWireFrameProtocol {
    func pushSearchJourney(from view: PickUpTimeViewProtocol, _ extraInfo: [String : AnyObject], _ builder: JourneyRequestBuilder) {
        if let vc = SearchJourneyWireFrame.createSearchJourneyViewController(builder, extraInfo), let view = view as? PickUpTimeViewController, let navigationController = view.navigationController {
            navigationController.pushViewController(vc, animated: false)
        }
    }
    
    static func createPickUpTimeViewController(_ extraInfo: [String : AnyObject], _ builder: JourneyRequestBuilder) -> PickUpTimeViewController? {
        if let vc = ViewService.viewController(PickUpTimeViewController.storyBoardId(), PickUpTimeViewController.storyBoardName()) as? PickUpTimeViewController {
            
            let presenter = PickUpTimePresenter()
            let wireFrame = PickUpTimeWireFrame()
            
            vc.presenter = presenter
            vc.extraInfo = extraInfo
            vc.builder = builder
            presenter.wireFrame = wireFrame
            presenter.view = vc
            
            return vc
        }
        return nil
    }
}
