//
//  JourneyListInteractorProtocol.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 11/15/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import RealmSwift

protocol JourneyListInteractorInputProtocol: class {
    var presenter: JourneyListInteractorOutputProtocol? { get set }
    var localDataManager: JourneyListLocalDataManagerProtocol? { get set}
    var remoteDataManager: JourneyListRemoteDataManagerInputProtocol? { get set }
    
    func initCurrentJourneyList()
    func initHistoryJourneyList()
    func getCurrentJourneyList()
    func getHistoryJourneyList()
    func registerCurrentJourneyListChange(_ list: Results<JourneyCurrent>)
    func registerHistoryJourneyListChange(_ historyList: Results<JourneyHistory>)
}

protocol JourneyListInteractorOutputProtocol: class {
    func didInitCurrentJourneyList(_ currentList: Results<JourneyCurrent>)
    func didInitHistoryJourneyList(_ historyList: Results<JourneyHistory>)
    func didReceiveChangeFromCurrentJourneyList(_ change: RealmCollectionChange<Results<JourneyCurrent>>)
    func didReceiveChangeFromHistoryJourneyList(_ change: RealmCollectionChange<Results<JourneyHistory>>)
    func didGetCurrentJourneyListSuccess()
    func didGetCurrentJourneyListFail()
    func didGetHistoryJourneyListSuccess()
    func didGetHistoryJourneyListFail()
}
