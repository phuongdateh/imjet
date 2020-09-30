//
//  PickUpTimePresenter.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 11/4/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

class PickUpTimePresenter: PickUpTimePresenterProtocol {
    weak var view: PickUpTimeViewProtocol?
    var wireFrame: PickUpTimeWireFrameProtocol?
    
    func pushSearchJourey(_ builder: JourneyRequestBuilder, _ extraInfo: [String : AnyObject]) {
        if let wireFrame = wireFrame, let view = view {
            wireFrame.pushSearchJourney(from: view, extraInfo, builder)
        }
    }
}
