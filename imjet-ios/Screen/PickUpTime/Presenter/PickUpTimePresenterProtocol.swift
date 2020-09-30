//
//  PickUpTimePresenterProtocol.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 11/4/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

protocol PickUpTimePresenterProtocol: class {
    var view: PickUpTimeViewProtocol? { get set }
    var wireFrame: PickUpTimeWireFrameProtocol? { get set }
    
    func pushSearchJourey(_ builder: JourneyRequestBuilder,_ extraInfo: [String: AnyObject])
}
