//
//  JourneyDetailPresenterProtocol.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 12/25/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

protocol JourneyDetailPresenterProtocol: class {
    var wireFrame: JourneyDetailWireFrameProtocol? { get set }
    var interactor: JourneyDetailInteractorInputProtocol? { get set }
    var view: JourneyDetailViewProtocol? { get set }
    
    var journey: Journey? { get set }
    var journeyId: Int? { get set }
    
    func viewDidLoad()
    func reloadData()
    
    func cancelJourney(_ journeyId: Int)
    func pushRating(_ journey: Journey)
    
}
