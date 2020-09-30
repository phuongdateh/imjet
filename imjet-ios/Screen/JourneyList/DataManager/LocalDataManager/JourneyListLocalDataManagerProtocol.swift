//
//  JourneyListLocalDataManagerProtocol.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 11/15/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import RealmSwift

protocol JourneyListLocalDataManagerProtocol: class {
    func initCurrentJournetList() -> Results<JourneyCurrent>
    func initHistoryJourneyList() -> Results<JourneyHistory>
}
