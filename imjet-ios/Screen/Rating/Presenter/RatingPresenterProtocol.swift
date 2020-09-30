//
//  RatingPresenterProtocol.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 1/2/20.
//  Copyright © 2020 DoanDuyPhuong. All rights reserved.
//

import Foundation

protocol RatingPresenterProtocol: class {
    var view: RatingViewProtocol? { get set }
    var wireFrame: RatingWireFrameProtocol? { get set }
    var interactor: RatingInteractorInputProtocol? { get set }
    
    var journey: Journey? { get set }
    
    func ratingJourney(id: Int, rating: Rating)
}
