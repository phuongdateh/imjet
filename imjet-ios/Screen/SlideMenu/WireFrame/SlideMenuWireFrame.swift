//
//  SlideMenuWireFrame.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 8/26/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import UIKit

class SlideMenuWireFrame: SlideMenuWireFrameProtocol {
    static func createSlideMenuViewController() -> SlideMenuViewController? {
        if let vc = ViewService.viewController(SlideMenuViewController.storyBoardId(), SlideMenuViewController.storyBoardName()) as? SlideMenuViewController {
            
            let presenter = SlideMenuPresenter()
            let wireFrame = SlideMenuWireFrame()
            
            presenter.view = vc
            presenter.wireFrame = wireFrame
            
            vc.presenter = presenter
            
            return vc
        }
        return nil
    }
    
    func pushProfile(from view: SlideMenuViewProtocol) {
        if let vc = ProfileWireFrame.createProfileViewController(), let view = view as? SlideMenuViewController, let navigationController = view.navigationController {
            navigationController.pushViewController(vc, animated: true)
        }
    }
}
