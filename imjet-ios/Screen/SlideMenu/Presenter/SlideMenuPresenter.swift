//
//  SlideMenuPresenter.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 9/23/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

class SlideMenuPresenter: SlideMenuPresenterProtocol {
    weak var view: SlideMenuViewProtocol?
    var wireFrame: SlideMenuWireFrameProtocol?
    
    func pushProfile() {
        if let wireFrame = wireFrame, let view = view {
            wireFrame.pushProfile(from: view)
        }
    }
}
