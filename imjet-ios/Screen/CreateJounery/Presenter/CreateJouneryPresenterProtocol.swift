//
//  CreateJouneryPresenterProtocol.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 10/20/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

protocol CreateJouneryPresenterProtocol: class {
    var wireFrame: CreateJouneryWireFrameProtocol? { get set }
    var interactor: CreateJouneryInteractorInputProtocol? { get set }
    var view: CreateJouneryViewProtocol? { get set }
    
    func getDirection(_ info: QueryGoogleModel)
    func pushSearchJourney(_ builder: JourneyRequestBuilder,_ extraInfo: [String: AnyObject])
    func pushPickUpTime(_ builder: JourneyRequestBuilder,_ extraInfo: [String: AnyObject])
}
