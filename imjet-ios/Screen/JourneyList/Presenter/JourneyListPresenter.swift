//
//  OrderListPresenter.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 11/15/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import RealmSwift

class JourneyListPresenter: JourneyListPresenterProtocol {
    weak var view: JourneyListViewProtocol?
    var interactor: JourneyListInteractorInputProtocol?
    var wireFrame: JourneyListWireFrameProtocol?
    
    var currentJourneyList: Results<JourneyCurrent>!
    var historyJourneyList: Results<JourneyHistory>!
    
    func viewDidLoad() {
        if let interactor = interactor {
            interactor.initCurrentJourneyList()
            interactor.initHistoryJourneyList()
        }
        
        if let view = view {
            view.beginLoading()
        }
    }
    
    
    func getCurrentJourneyList() {
        if let interactor = interactor {
            interactor.getCurrentJourneyList()
        }
    }
    
    func getHistoryJourneyList() {
        if let interactor = interactor {
            interactor.getHistoryJourneyList()
        }
    }
    
    func pushJourneyDetail(_ journeyId: Int) {
        if let wireFrame = wireFrame, let view = view {
            wireFrame.pushJourneyDetail(journeyId: journeyId, from: view)
        }
    }
}

extension JourneyListPresenter: JourneyListInteractorOutputProtocol {
    func didInitCurrentJourneyList(_ currentList: Results<JourneyCurrent>) {
        self.currentJourneyList = currentList
        if let currentList = self.currentJourneyList {
            if let interactor = interactor {
                interactor.registerCurrentJourneyListChange(currentList)
            }
        }
    }
    
    func didInitHistoryJourneyList(_ historyList: Results<JourneyHistory>) {
        self.historyJourneyList = historyList
        if let historyList = self.historyJourneyList, let interactor = interactor {
            interactor.registerHistoryJourneyListChange(historyList)
        }
    }
    
    func didReceiveChangeFromHistoryJourneyList(_ change: RealmCollectionChange<Results<JourneyHistory>>) {
        if let view = view {
            view.reloadData()
        }
    }
    
    func didReceiveChangeFromCurrentJourneyList(_ change: RealmCollectionChange<Results<JourneyCurrent>>) {
        if let view = view {
            view.reloadData()
        }
    }
    
    func didGetHistoryJourneyListSuccess() {
        if let view = view {
            view.endLoading()
        }
    }
    
    func didGetHistoryJourneyListFail() {
        if let view = view {
            view.endLoading()
        }
    }
    
    func didGetCurrentJourneyListSuccess() {
        if let view = view {
            view.endLoading()
        }
    }
    
    func didGetCurrentJourneyListFail() {
        if let view = view {
            view.endLoading()
        }
    }
}
