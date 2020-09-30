//
//  SlideMenuWireFrameProtocol.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 8/26/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import UIKit

protocol SlideMenuWireFrameProtocol: class {
    static func createSlideMenuViewController() -> SlideMenuViewController?
    
    func pushProfile(from view: SlideMenuViewProtocol)
}
