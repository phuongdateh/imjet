//
//  SearchJourneyRemoteDataManager.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 10/26/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import RealmSwift
import ObjectMapper

class SearchJourneyRemoteDataManager: SearchJourneyRemoteDataManagerInputProtocol {
    var remoteRequestHandler: SearchJourneyRemoteDataManagerOutputProtocol?
    
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
    
    func getGlobalFee(_ globalRequest: GlobalFeeRequest) {
        APIServiceManager.sharedInstance.postGlobalFeeEstimate(globalRequest) { [weak self] (errorPackage, responsePackage) in
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
                    if let weakSelf = self, let remoteRequestHandler = weakSelf.remoteRequestHandler {
                        remoteRequestHandler.didGetGlobalFeeSuccess(totalFee)
                    }
                }
                return
            }
        }
    }
    
}
