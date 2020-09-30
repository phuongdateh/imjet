//
//  SearchAddressRemoteDataManager.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 10/2/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import CoreLocation

class SearchAddressRemoteDataManager: SearchAddressRemoteDataManagerInputProtocol {
    weak var remoteRequestHandler: SearchAddressRemoteDataManagerOutputProtocol?
    var countFetch: Int = 0
    func getDirecton(startAddress: String, endAddress: String) {
       
    }
    
    func lookUpAddress(location: CLLocation) {
        countFetch += 1
        print("CLLocation request :\(countFetch)")
        APIServiceManager.sharedInstance.getCurrentAddress(by: location.coordinate) { [weak self] (errorPackage, responsePackage) in
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
                                        if let weakSelf = self, let remoteRequestHandler = weakSelf.remoteRequestHandler,let geocode = JSONDecoder().map(GoogleGeocode.self, from: results[0]) {
                                            remoteRequestHandler.didLookUpAddressSuccess(info: geocode, for: location.coordinate)
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
}
