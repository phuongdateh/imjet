//
//  OrderListPresenterProtocol.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 11/15/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import RealmSwift

protocol JourneyListPresenterProtocol: class {
    var wireFrame: JourneyListWireFrameProtocol? { get set }
    var view: JourneyListViewProtocol? { get set }
    var interactor: JourneyListInteractorInputProtocol? { get set }
    
    var currentJourneyList: Results<JourneyCurrent>! { get set }
    var historyJourneyList: Results<JourneyHistory>! { get set }
    
    func viewDidLoad()
    
    func getCurrentJourneyList()
    func getHistoryJourneyList()
    
    func pushJourneyDetail(_ journeyId: Int)
}
