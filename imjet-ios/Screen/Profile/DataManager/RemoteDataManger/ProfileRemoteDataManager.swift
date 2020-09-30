//
//  ProfileRemoteDataManager.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 9/23/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class ProfileRemoteDataManager: ProfileRemoteDataManagerInputProtocol {
    weak var remoteRequestHandler: ProfileRemoteDataManagerOutputProtocol?
    
    func getUser() {
        APIServiceManager.sharedInstance.getProfile { [weak self] (errorPackage, responsePackage) in
            if let errorPackage = errorPackage, let errorData = errorPackage.value as? [[String: Any]] {
                for error in errorData {
                    if let error = error["errors"] as? [String: AnyObject] {
                        if let code = error["code"] as? Int {
                            if let weakSelf = self, let remoteRequestHandler = weakSelf.remoteRequestHandler {
                                remoteRequestHandler.didGetUserFail()
                                Log.error(">>> ErrorCode: \(code)")
                                return
                            }
                        }
                    }
                }
            }
            else if let responsePackage = responsePackage, let value = responsePackage.value as? [String: AnyObject], let data = value[Constants.kData] as? [String: AnyObject] {
                let map = Map.init(mappingType: .fromJSON, JSON: data)
                if let user = User.init(map: map) {
                    user.mapping(map: map)
                    UserDefaults.standard.setValue(user.id, forKey: Constants.currentUserId)
                    UserDefaults.standard.synchronize()
                    let realm = try! Realm()
                    realm.safeWrite {
                        realm.add(user, update: .all)
                    }
                    if let weakSelf = self, let remoteRequestHandler = weakSelf.remoteRequestHandler {
                        remoteRequestHandler.didGetUserSuccess()
                        Log.verbose(">>> User Info: \(user)")
                        return
                    }
                }
            }
            else {
                if let weakSelf = self, let remoteRequestHandler = weakSelf.remoteRequestHandler {
                    remoteRequestHandler.didGetUserFail()
                    return
                }
            }
        }
    }
}
