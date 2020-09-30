//
//  OrderListWireFrameProtocol.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 11/14/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

protocol JourneyListWireFrameProtocol: class {
    static func createOrderListViewController() -> JourneyListViewController?
    
    func pushJourneyDetail(journeyId: Int, from view: JourneyListViewProtocol)
}
