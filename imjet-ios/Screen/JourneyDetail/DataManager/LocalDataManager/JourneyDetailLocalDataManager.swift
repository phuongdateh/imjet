//
//  JourneyDetailLocalDataManager.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 12/25/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import RealmSwift

class JourneyDetailLocalDataManager: JourneyDetailLocalDataManagerProtocol {
    func initJourney(journeyId: Int) -> Journey? {
        let realm = try! Realm()
        return realm.object(ofType: Journey.self, forPrimaryKey: journeyId)
    }
}
