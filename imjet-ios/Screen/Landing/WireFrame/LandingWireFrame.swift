//
//  LandingWireFrame.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 4/3/20.
//  Copyright © 2020 DoanDuyPhuong. All rights reserved.
//

import Foundation

class LandingWireFrame: LandingWireFrameProtocol {
    static func createLandingViewController() -> LandingViewConroller? {
        let vc = LandingViewConroller.init()
        vc.hidesBottomBarWhenPushed = true
        
        return vc
    }
}
