//
//  JourneyViewProtocol.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 11/27/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

protocol JourneyViewProtocol: class {
    var presenter: JourneyPresenterProtocol? { get set }
    
    func didGetCurrentAddressSuccess(info: GoogleGeocode)
    func didGetCurrentAddressFail()
    func didGetDirectionFail()
    func didGetDirectionSuccess(googleDirection: GoogleDirection)
    func didGetGlobalFeeSuccess(_ totalFee: Float)
    func didGetGlobalFeeFail()
    func didCreateJourneySuccess(_ journey: Journey)
    func didCreateJourneyFail()
}
