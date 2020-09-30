//
//  JourneyDetailRemoteDataManger.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 12/25/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class JourneyDetailRemoteDataManager: JourneyDetailRemoteDataManagerInputProtocol {
    weak var remoteRequestHandler: JourneyDetailRemoteDataManagerOutputProtocol?
    
    func reloadJourney(_ journeyId: Int) {
        
        // here i fetch list journey, form server
        APIServiceManager.sharedInstance.reloadJourney(journeyId) { [weak self] (errorPackage, responsePackage) in
            if errorPackage != nil {
                if let weakSelf = self, let remoteRequestHandler = weakSelf.remoteRequestHandler {
                    remoteRequestHandler.didReloadJourneyFail()
                    return
                }
            }
            else if let responsePackage = responsePackage,
                let value = responsePackage.value as? [String: AnyObject],
                let data = value[Constants.kData] as? [String: AnyObject] {
                let map = Map.init(mappingType: .fromJSON, JSON: data)
                let realm = try! Realm()
                if let journey = Journey.init(map: map) {
                    journey.mapping(map: map)
                    realm.safeWrite {
                        realm.add(journey, update: .all)
                    }
                }
                if let weakSelf = self, let remoteRequestHandler = weakSelf.remoteRequestHandler {
                    remoteRequestHandler.didReloadJourneySuccess()
                    return
                }
            }
            else {
                if let weakSelf = self, let remoteRequestHandler = weakSelf.remoteRequestHandler {
                    remoteRequestHandler.didReloadJourneyFail()
                    return
                }
            }
        }
    }
    
    func cancelJourney(_ journeyId: Int) {
        APIServiceManager.sharedInstance.cancelJourney(journeyId) { [weak self] (errorResponse, responsePackage) in
            if let _ = errorResponse {
                if let weakSelf = self, let remoteRequestHandler = weakSelf.remoteRequestHandler {
                    remoteRequestHandler.didCancelJourneyFail()
                    return
                }
            }
            else if let _ = responsePackage {
                if let weakSelf = self, let remoteRequestHandler = weakSelf.remoteRequestHandler {
                    remoteRequestHandler.didCancelJourneySuccess()
                }
            }
        }
    }
}
