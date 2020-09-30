//
//  ProvicePurposePresenter.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 9/21/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

class ProvicePurposePresenter: ProvicePurposePresenterProtocol {
    weak var view: ProvicePurposeViewProtocol?
    var interactor: ProvicePurposeInteractorInputProtocol?
    var wireFrame: ProvicePurposeWireFrameProtocol?
    
    func pushJourney(with state: JourneyViewControllerState, _ builder: JourneyRequestBuilder) {
        if let wireFrame = wireFrame, let view = view {
            wireFrame.pushJourney(from: view, with: state, builder)
        }
    }
    
    func provicePurpose(_ purpose: UserPurpose) {
        if let interactor = interactor {
            interactor.provicePurpose(purpose)
        }
    }
    
    func pushSearchAddress(_ builder: JourneyRequestBuilder) {
        if let wireFrame = wireFrame, let view = view {
            wireFrame.pushSearchAddress(from: view, builder: builder)
        }
    }
    
    func getProfile() {
        if let interactor = interactor {
            interactor.getProfile()
        }
    }
}

extension ProvicePurposePresenter: ProvicePurposeInteractorOutputProtocol {
    func didProvicePurposeSuccess() {
        if let view = view {
            view.didProvicePurposeSuccess()
        }
    }
    
    func didProvicePurposeFail(_ code: Int) {
        if let view = view {
            view.didProvicePurposeFail(code)
        }
    }
}
