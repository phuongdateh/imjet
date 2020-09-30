//
//  RatingViewProtocol.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 1/2/20.
//  Copyright © 2020 DoanDuyPhuong. All rights reserved.
//

import Foundation

protocol RatingViewProtocol: class {
    var presenter: RatingPresenterProtocol? { get set }
    
    func didRatingJourneySuccess()
    func didRatingJourneyFail()
}
