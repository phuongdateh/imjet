//
//  ProvicePurposeRemoteDataManager.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 9/21/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import ObjectMapper
import RealmSwift

class ProvicePurposeRemoteDataManager: ProvicePurposeRemoteDataManagerInputProtocol {
    var remoteRequestHandler: ProvicePurposeRemoteDataManagerOutputProtocol?
    
    func provicePurpose(_ purpose: UserPurpose) {
        APIServiceManager.sharedInstance.provicePurpose(purpose) {[weak self] (errorPackage, responsePackage) in
            if let errorPackage = errorPackage, let value = errorPackage.value as? [String: AnyObject] {
                if let errors = value["errors"] as? [[String:AnyObject]] {
                    var codeInt: Int = 0
                    for error in errors {
                        if let code = error["code"] as? Int {
                            codeInt = code
                        }
                    }
                    if let weakSelf = self, let remoteRequestHandler = weakSelf.remoteRequestHandler {
                        remoteRequestHandler.didProvicePurposeFail(codeInt)
                    }
                }
                return
            }
            else if let responsePackage = responsePackage, let value = responsePackage.value as? [String: AnyObject], let data = value["data"] as? [String: AnyObject] {
                print("Data: \(data)")
                if let weakSelf = self, let remoteRequestHandler = weakSelf.remoteRequestHandler {
                    remoteRequestHandler.didProvicePurposeSuccess()
                }
                return
            }
        }
    }
    
    func getProfile() {
        APIServiceManager.sharedInstance.getProfile { (errorPackage, responsePackage) in
            if let responsePackage = responsePackage,
                let value = responsePackage.value as? [String: AnyObject],
                let data = value[Constants.kData] as? [String: AnyObject] {
                let map = Map.init(mappingType: .fromJSON, JSON: data)
                let realm = try! Realm()
                if let profile = Profile.init(map: map) {
                    profile.mapping(map: map)
                    UserDefaults.standard.setValue(profile.id, forKey: Constants.kProfileId)
                    UserDefaults.standard.setValue("0\(String(describing: profile.phoneNumber))", forKey: Constants.kPhoneProfile)
                    realm.safeWrite {
                        realm.add(profile, update: .all)
                    }
                }
                return
            }
            else if let errorPackage = errorPackage, let errorCode = errorPackage.code {
                Log.error("ErrorCodeProfile: \(errorCode)")
            }
        }
    }
}
