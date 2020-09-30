//
//  JourneyDetailWireFrameProtocol.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 12/25/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

protocol JourneyDetailWireFrameProtocol: class {
    static func createJourneyDetailViewController(_ journeyId: Int) -> JourneyDetailViewController?
    
    func pushRating(from view: JourneyDetailViewProtocol,_ journey: Journey)
}
