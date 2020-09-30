//
//  ChooseAddressRemoteDataManager.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 10/17/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

class ChooseAddressRemoteDataManager: ChooseAddressRemoteDataManagerInputProtocol {
    weak var remoteRequestHandler: ChooseAddressRemoteDataManagerOutputProtocol?
    
    func getAutocomple(string: String) {
        APIServiceManager.sharedInstance.getAutocomplete(string: string) {[weak self] (errorPackage, responsePackage) in
            if let errorPackage = errorPackage, let code = errorPackage.code {
                print("ErrorPackage.Code:\(code)")
                if let weakSelf = self, let remoteRequestHandler = weakSelf.remoteRequestHandler {
                    remoteRequestHandler.didLookUpAddressFromStrFail()
                    return
                }
            }
            else if let responsePackage = responsePackage,
                let value = responsePackage.value as? [String: AnyObject],
                let data = value[Constants.kData] as? [String: AnyObject],
                let status = data["status"] as? String,
                status == "OK",
                let results = data["predictions"] as? [[String: AnyObject]] {
                if let weakSelf = self, let remoteRequestHandler = weakSelf.remoteRequestHandler {
                    var placeList: [GooglePlace] = []
                    for result in results {
                        if let place = JSONDecoder().map(GooglePlace.self, from: result) {
                            placeList.append(place)
                        }
                    }
                    remoteRequestHandler.didLookUpAddressFromStrSuccess(placeList: placeList)
                }
                return
            }
        }
    }
    
    func getCurrentAddress() {
        if let currentLocation = JETLocationManager.sharedInstance.currentLocation {
            APIServiceManager.sharedInstance.getCurrentAddress(by: currentLocation.coordinate) {[weak self] (errorPackage, responsePackage) in
                if let errorPackage = errorPackage, let code = errorPackage.code {
                    print(code)
                    if let weakSelf = self, let remoteRequestHandler = weakSelf.remoteRequestHandler {
                        remoteRequestHandler.didGetCurrentAddressFail()
                    }
                    return
                }
                else if let responsePackage = responsePackage {
                    if let value = responsePackage.value as? [String: AnyObject] {
                        if let data = value[Constants.kData] as? [String: AnyObject] {
                            if let status = data["status"] as? String {
                                if status == "OK" {
                                    if let results = data["results"] as? [[String: AnyObject]] {
                                        if results.count > 0 {
                                            if let weakSelf = self, let remoteRequestHandler = weakSelf.remoteRequestHandler,
                                                let geocode = JSONDecoder().map(GoogleGeocode.self, from: results[0]) {
                                                remoteRequestHandler.didGetCurrentAddressSuccess(info: geocode)
                                                return
                                            }
                                        }
                                    }
                                }
                            }
                        }
                    }
                    return
                }
            }
        }
        else {
            if let remoteRequestHandler = remoteRequestHandler {
                remoteRequestHandler.didGetCurrentAddressFail()
                return
            }
        }
    }
    
}
