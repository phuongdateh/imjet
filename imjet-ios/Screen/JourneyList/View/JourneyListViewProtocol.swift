//
//  OrderListViewProtocol.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 11/15/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import RealmSwift

protocol JourneyListViewProtocol: class {
    var presenter: JourneyListPresenterProtocol? { get set }
    
    func reloadData()
    func beginLoading()
    func endLoading()
}
