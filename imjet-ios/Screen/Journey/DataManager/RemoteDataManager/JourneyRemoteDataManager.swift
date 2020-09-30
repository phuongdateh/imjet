//
//  JourneyRemoteDataManager.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 12/7/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import  ObjectMapper

class JourneyRemoteDataManager: JourneyRemoteDataManagerInputProtocol {
    weak var remoteRequestHandler: JourneyRemoteDataManagerOutputProtocol?
    
    func createJourney(_ builder: JourneyRequestBuilder) {
        APIServiceManager.sharedInstance.createJourney(builder) { [weak self] (errorPackage, responsePackage) in
            if let responsePackage = responsePackage,
                let value = responsePackage.value as? [String: AnyObject],
                let data = value[Constants.kData] as? [String: AnyObject] {
                let map = Map.init(mappingType: .fromJSON, JSON: data)
                if let jourey = Journey.init(map: map) {
                    jourey.mapping(map: map)
                    if let weakSelf = self, let remoteRequestHandler = weakSelf.remoteRequestHandler {
                        remoteRequestHandler.didCreateJourneySuccess(jourey)
                    }
                    return
                }
            }
            else if let errorPackage = errorPackage,
                let code = errorPackage.code,
                let value = errorPackage.value as? [String: AnyObject],
                let errorData = value["errors"] as? [[String: AnyObject]] {
                for error in errorData {
                    let code = error["code"] as? Int
                    if code == 26 {
                        ToastView.sharedInstance.showContent("Thời gian khởi hành bị xung đột")
                    }
                    else if code == 35 {
                        ToastView.sharedInstance.showContent("DIRECTION_REQUEST_ID_INVALID")
                    }
                    else if code == 22 {
                        //limit time
                        ToastView.sharedInstance.showContent("Bạn chỉ được đặt chuyến từ 6h:00 - 20h:00")
                    }
                    else {
                        ToastView.sharedInstance.showContent("Tạo lỗ trình thất bại")
                    }
                }
                print("ErrorCode: \(code)")
                if let weakSelf = self, let remoteRequestHandler = weakSelf.remoteRequestHandler {
                    remoteRequestHandler.didCreateJourneyFail()
                }
                return
            }
        }
    }
    
    func getDirection(_ info: QueryGoogleModel) {
        APIServiceManager.sharedInstance.getDirection(infoQuery: info) { [weak self] (errorPackage, responsePackage) in
            if let errorPackage = errorPackage, let code = errorPackage.code {
                print("ErrorCode: \(code)")
                if let weakSelf = self, let remoteRequestHandler = weakSelf.remoteRequestHandler {
                    remoteRequestHandler.didGetDirectionFail()
                }
                return
            }
            else if let responsePackage = responsePackage,
                let value = responsePackage.value as? [String: AnyObject],
                let data = value[Constants.kData] as? [String: AnyObject],
                let status = data["status"] as? String,
                status == "OK" {
                if let direction = JSONDecoder.init().map(GoogleDirection.self, from: data) {
                    if let weakSelf = self, let remoteRequestHandler = weakSelf.remoteRequestHandler {
                        remoteRequestHandler.didGetDirectionSuccess(googleDirection: direction)
                        return
                    }
                }
            }
        }
    }
    
    func getCurrentAddress() {
        if let currentLocation = JETLocationManager.sharedInstance.currentLocation {
            APIServiceManager.sharedInstance.getCurrentAddress(by: currentLocation.coordinate) {[weak self] (errorPackage, responsePackage) in
                if let errorPackage = errorPackage, let code = errorPackage.code {
                    print(code)
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
    
    func getGlobalFee(_ request: GlobalFeeRequest) {
        APIServiceManager.sharedInstance.postGlobalFeeEstimate(request) { [weak self] (errorPackage, responsePackage) in
            if let errorPackage = errorPackage, let code = errorPackage.code {
                print("ErrorCode: \(code)")
                if let weakSelf = self, let remoteRequestHandler = weakSelf.remoteRequestHandler {
                    remoteRequestHandler.didGetGlobalFeeFail()
                }
                return
            }
            else if let responsePackage = responsePackage,
                let statusCode = responsePackage.code,
                statusCode == 200,
                let value = responsePackage.value as? [String: AnyObject],
                let data = value[Constants.kData] as? [String: AnyObject] {
                if let totalFee = data["totalFee"] as? Float {
                    if let weakSelf = self,
                        let remoteRequestHandler = weakSelf.remoteRequestHandler {
                        remoteRequestHandler.didGetGlobalFeeSuccess(totalFee)
                    }
                }
                return
            }
        }
    }
}
