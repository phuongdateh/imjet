//
//  JourneyListLocalDataManager.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 11/15/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import RealmSwift

class JourneyListLocalDataManager: JourneyListLocalDataManagerProtocol {
    func initCurrentJournetList() -> Results<JourneyCurrent> {
        return JourneyCurrent.getJourneyCurrentList()
    }
    
    func initHistoryJourneyList() -> Results<JourneyHistory> {
        return JourneyHistory.getJourneyHistoryList()
    }
}
