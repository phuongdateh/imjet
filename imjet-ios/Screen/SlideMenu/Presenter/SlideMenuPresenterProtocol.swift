//
//  SlideMenuPresenterProtocol.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 9/23/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

protocol SlideMenuPresenterProtocol: class {
    var view: SlideMenuViewProtocol? { get set }
    var wireFrame: SlideMenuWireFrameProtocol? { get set }
    
    func pushProfile()
}
