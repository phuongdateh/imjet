//
//  OrderListInteractor.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 11/15/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import RealmSwift

class JourneyListInteractor: JourneyListInteractorInputProtocol {
    weak var presenter: JourneyListInteractorOutputProtocol?
    var remoteDataManager: JourneyListRemoteDataManagerInputProtocol?
    var localDataManager: JourneyListLocalDataManagerProtocol?
    
    var currentListNotification: NotificationToken?
    var historyListNotification: NotificationToken?
    
    func initCurrentJourneyList() {
        if let localDataManager = localDataManager, let presenter = presenter {
            presenter.didInitCurrentJourneyList(localDataManager.initCurrentJournetList())
        }
    }
    
    func initHistoryJourneyList() {
        if let localDataManager = localDataManager,
            let presenter = presenter {
            presenter.didInitHistoryJourneyList(localDataManager.initHistoryJourneyList())
        }
    }
    
    func getHistoryJourneyList() {
        if let remoteDataManager = remoteDataManager {
            remoteDataManager.getHistoryJourneyList()
        }
    }
    
    func getCurrentJourneyList() {
        if let remoteDataManager = remoteDataManager {
            remoteDataManager.getCurrentJourneyList()
        }
    }
    
    func registerCurrentJourneyListChange(_ list: Results<JourneyCurrent>) {
        currentListNotification = list.observe({[weak self] (changes: RealmCollectionChange) in
            if let weakSelf = self, let presenter = weakSelf.presenter {
                presenter.didReceiveChangeFromCurrentJourneyList(changes)
            }
            return
        })
    }
    
    func registerHistoryJourneyListChange(_ historyList: Results<JourneyHistory>) {
        historyListNotification = historyList.observe({ [weak self] (change: RealmCollectionChange) in
            if let weakSelf = self,
                let presenter = weakSelf.presenter {
                presenter.didReceiveChangeFromHistoryJourneyList(change)
            }
        })
    }
}

extension JourneyListInteractor: JourneyListRemoteDataManagerOutputProtocol {
    func didGetCurrentJourneyListSuccess() {
        if let presenter = presenter {
            presenter.didGetCurrentJourneyListSuccess()
        }
    }
    
    func didGetCurrentJourneyListFail() {
        if let presenter = presenter {
            presenter.didGetCurrentJourneyListFail()
        }
    }
    
    func didGetHistoryJourneyListSuccess() {
        if let presenter = presenter {
            presenter.didGetHistoryJourneyListSuccess()
        }
    }
    
    func didGetHistoryJourneyListFail() {
        if let presenter = presenter {
            presenter.didGetCurrentJourneyListFail()
        }
    }
    
    func didLoadMoreCurrentJourneyListSuccess() {
        
    }
    
    func didLoadMoreCurrentJourneyListFail() {
        
    }
    
    func didLoadMoreHistoryJourneyListSuccess() {
        
    }
    
    func didLoadMoreHistoryJourneyListFail() {
        
    }
    
    
}
