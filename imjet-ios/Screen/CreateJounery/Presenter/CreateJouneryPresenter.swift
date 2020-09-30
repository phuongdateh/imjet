//
//  CreateJouneryPresenter.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 10/20/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

class CreateJouneryPresenter: CreateJouneryPresenterProtocol {
    weak var view: CreateJouneryViewProtocol?
    var interactor: CreateJouneryInteractorInputProtocol?
    var wireFrame: CreateJouneryWireFrameProtocol?
    
    func getDirection(_ info: QueryGoogleModel) {
        if let interactor = interactor {
            interactor.getDirection(info)
        }
    }
    
    func pushSearchJourney(_ builder: JourneyRequestBuilder,_ extraInfo: [String: AnyObject]) {
        if let wireFrame = wireFrame, let view = view {
            wireFrame.pushSearchJourney(from: view, builder, extraInfo)
        }
    }
    
    func pushPickUpTime(_ builder: JourneyRequestBuilder, _ extraInfo: [String : AnyObject]) {
        if let wireFrame = wireFrame, let view = view {
            wireFrame.pushPickUpTime(from: view, builder, extraInfo)
        }
    }
}

extension CreateJouneryPresenter: CreateJouneryInteractorOutputProtocol {
    func didGetDirectionSuccess(_ infoDirection: GoogleDirection) {
        if let view = view {
            view.didGetDirectionSuccess(infoDirection)
        }
    }
    
    func didGetDirectionFail() {
        if let view = view {
            view.didGetDirectionFail()
        }
    }
}
