//
//  OrderListRemoteDataManager.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 11/15/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class JourneyListRemoteDataManager: JourneyListRemoteDataManagerInputProtocol {
    var remoteRequestHandler: JourneyListRemoteDataManagerOutputProtocol?
    var nextID: Int?
    
    func getCurrentJourneyList() {
        APIServiceManager.sharedInstance.getJoureys(isHistory: false) { [weak self] (errorPackage, responsePackage) in
            if let errorPackage = errorPackage,
                let errorData = errorPackage.value as? [[String: AnyObject]],
                let code = errorPackage.code {
                Log.error("ErrorCodeCurrentJournetList: \(code)")
                for error in errorData {
                    let code = error["code"] as? Int
                    if code == 4 {
                        Log.error("UNAUTHORIZED")
                    }
                    else if code == 5 {
                        Log.error("BODY_INVALID")
                    }
                    else if code == 6 {
                        Log.error("REQUEST_INVALID")
                    }
                    else if code == 25 {
                        Log.error("JOURNEY_NOT_FOUND")
                    }
                }
            }
            else if let responsePackage = responsePackage, let value = responsePackage.value as? [String: AnyObject], let data = value[Constants.kData] as? [[String: AnyObject]] {
                let realm = try! Realm()
                realm.safeWrite {
                    let tmpList = JourneyCurrent.getJourneyCurrentList()
                    var orderNumber: Int = 0
                    var exitsedListId: [String] = []
                    for json in data {
                        let map = Map.init(mappingType: .fromJSON, JSON: json)
                        if let journey = Journey.init(map: map) {
                            journey.mapping(map: map)
                            let journeyHistory = JourneyCurrent.init(journey: journey, group: JourneyListType.current.rawValue, orderNumber: orderNumber)
                            exitsedListId.append(journeyHistory.id)
                            orderNumber += 1
                            realm.add(journeyHistory,update: .all)
                        }
                    }
                    let notExistList = tmpList.filter(NSPredicate.init(format: "NOT (id IN %@)", exitsedListId))
                    realm.delete(notExistList)
                }
                
                if let weakSelf = self, let remoteRequestHandler = weakSelf.remoteRequestHandler {
                    remoteRequestHandler.didGetCurrentJourneyListSuccess()
                    return
                }
            }
            
        }
    }
    
    func getHistoryJourneyList() {
        APIServiceManager.sharedInstance.getJoureys(isHistory: true) { [weak self] (errorPackage, responsePackage) in
            if let errorPackage = errorPackage,
                let errorData = errorPackage.value as? [[String: AnyObject]],
                let code = errorPackage.code {
                Log.error("ErrorCodeHistoryJournetList: \(code)")
                for error in errorData {
                    let code = error["code"] as? Int
                    if code == 4 {
                        Log.error("UNAUTHORIZED")
                    }
                    else if code == 5 {
                        Log.error("BODY_INVALID")
                    }
                    else if code == 6 {
                        Log.error("REQUEST_INVALID")
                    }
                    else if code == 25 {
                        Log.error("JOURNEY_NOT_FOUND")
                    }
                }
                if let weakSelf = self, let remoteRequestHandler = weakSelf.remoteRequestHandler {
                    remoteRequestHandler.didGetHistoryJourneyListFail()
                    return
                }
            }
            else if let responsePackage = responsePackage, let value = responsePackage.value as? [String: AnyObject], let data = value[Constants.kData] as? [[String: AnyObject]] {
                let realm = try! Realm()
                realm.safeWrite {
                    let tmpList = JourneyHistory.getJourneyHistoryList()
                    var existListId: [String] = []
                    var orderNumber: Int = 0
                    for json in data {
                        let map = Map.init(mappingType: .fromJSON, JSON: json)
                        if let journey = Journey.init(map: map) {
                            journey.mapping(map: map)
                            let historyJourney = JourneyHistory.init(journey: journey, group: JourneyListType.history.rawValue, orderNumber: orderNumber)
                            orderNumber += 1
                            existListId.append(historyJourney.id)
                            realm.add(historyJourney, update: .all)
                        }
                    }
                    let notExistList = tmpList.filter(NSPredicate.init(format: "NOT (id IN %@)", existListId))
                    realm.delete(notExistList)
                }
                
                if let weakSelf = self, let remoteRequestHandler = weakSelf.remoteRequestHandler {
                    remoteRequestHandler.didGetHistoryJourneyListSuccess()
                    return
                }
            }
        }
    }
    
    func loadMoreCurrentJourney() {
        if let nextID = nextID {
            var queryParam: [String: AnyObject] = [:]
            queryParam["isHistory"] = "false" as AnyObject
            queryParam["nextID"] = String.init(describing: nextID) as AnyObject
            APIServiceManager.sharedInstance.makeCustomRequest(requestType: .get, endPoint: "journeys", parameters: queryParam, extraHeaders: nil, forAuthenticate: false, port: .core) { (errorPackage, responsePackage) in
                
            }
        }
    }
    
    func loadMoreHistoryJourneyList() {
        if let nextID = nextID {
            var queryParam: [String: AnyObject] = [:]
            queryParam["isHistory"] = "true" as AnyObject
            queryParam["nextID"] = String.init(describing: nextID) as AnyObject
            APIServiceManager.sharedInstance.makeCustomRequest(requestType: .get, endPoint: "journeys", parameters: queryParam, extraHeaders: nil, forAuthenticate: false, port: .core) { (errorPackage, responsePackage) in
                
            }
        }
    }
}
