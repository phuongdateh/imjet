//
//  SearchJourneyViewProtocol.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 10/26/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

protocol SearchJourneyViewProtocol: class {
    var presenter: SearchJourneyPresenterProtocol? { get set }
    
    func didCreateJourneySuccess(_ journey: Journey)
    func didCreateJourneyFail()
    func didGetGlobalFeeSuccess(_ totalFee: Float)
    func didGetGlobalFeeFail()
}
