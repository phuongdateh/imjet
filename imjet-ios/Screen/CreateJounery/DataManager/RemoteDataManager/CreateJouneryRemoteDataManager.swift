//
//  CreateJouneryRemoteDataManager.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 10/20/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import ObjectMapper

class CreateJouneryRemoteDataManager: CreateJouneryRemoteDataManagerInputProtocol {
    weak var remoteRequestHandler: CreateJouneryRemoteDataManagerOutputProtocol?
    
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
                        remoteRequestHandler.didGetDirectionSuccess(direction)
                        return
                    }
                }
            }
        }
    }
}
