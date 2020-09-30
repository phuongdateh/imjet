//
//  RatingWireFrameProtocol.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 1/2/20.
//  Copyright © 2020 DoanDuyPhuong. All rights reserved.
//

import Foundation

protocol RatingWireFrameProtocol: class {
    static func createRatingViewController(journey: Journey) -> RatingViewController?
}
