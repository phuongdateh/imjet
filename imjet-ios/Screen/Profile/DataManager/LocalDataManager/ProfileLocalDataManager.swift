//
//  ProfileLocalDataManager.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 9/23/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import RealmSwift

class ProfileLocalDataManager: ProfileLocalDataManagerProtocol {
    func initUser() -> User? {
        let realm = try! Realm()
        if let currentUserId = UserDefaults.standard.object(forKey: Constants.currentUserId) as? Int {
            return realm.object(ofType: User.self, forPrimaryKey: currentUserId)
        }
        return nil
    }
}
