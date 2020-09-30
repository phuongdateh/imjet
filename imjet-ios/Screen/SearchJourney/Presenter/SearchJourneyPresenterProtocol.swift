//
//  SearchJourneyPresenterProtocol.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 10/26/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

protocol SearchJourneyPresenterProtocol: class {
    var view: SearchJourneyViewProtocol? { get set }
    var wireFrame: SearchJourneyWireFrameProtocol? { get set }
    var interactor: SearchJourneyInteractorInputProtocol? { get set }
    
    func createJourney(_ builder: JourneyRequestBuilder)
    func getGlobalFee(_ globalRequest: GlobalFeeRequest)
}
