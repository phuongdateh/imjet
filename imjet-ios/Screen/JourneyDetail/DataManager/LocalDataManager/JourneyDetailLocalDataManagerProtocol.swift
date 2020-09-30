//
//  JourneyDetailLocalDataManagerProtocol.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 12/25/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

protocol JourneyDetailLocalDataManagerProtocol: class {
    func initJourney(journeyId: Int) -> Journey?
}
