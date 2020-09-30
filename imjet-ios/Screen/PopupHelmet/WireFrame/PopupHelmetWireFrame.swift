//
//  PopupHelmetWireFrame.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 12/11/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

class PopupHelmetWireFrame: PopupHelmetWireFrameProtocol {
    static func createPopupHelmetViewController(_ builder: JourneyRequestBuilder) -> PopupHelmetViewController? {
        if let vc = PopupHelmetViewController.initWithStoryboard() as? PopupHelmetViewController {
            
            vc.builder = builder
            
            
            return vc
        }
        return nil
    }
}
