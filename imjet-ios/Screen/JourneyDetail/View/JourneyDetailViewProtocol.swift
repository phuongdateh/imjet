//
//  JourneyDetailViewProtocol.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 12/25/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

protocol JourneyDetailViewProtocol: class {
    var presenter: JourneyDetailPresenter? { get set }
    
    func beginLoading()
    func stopLoading()
    func updateView()
    
    func didCancelJourneySuccess()
    func didCancelJourneyFail()
}
