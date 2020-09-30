//
//  SearchJourneyWireFrameProtocol.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 10/26/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

protocol SearchJourneyWireFrameProtocol: class {
    static func createSearchJourneyViewController(_ builder: JourneyRequestBuilder,_ extraInfo: [String: AnyObject]) -> SearchJourneyViewController?
}
