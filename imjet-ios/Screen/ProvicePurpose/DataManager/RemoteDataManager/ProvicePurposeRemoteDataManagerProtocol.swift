//
//  ProvicePurposeRemoteDataManagerProtocol.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 9/21/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

protocol ProvicePurposeRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: ProvicePurposeRemoteDataManagerOutputProtocol? { get set }
    
    func provicePurpose(_ purpose: UserPurpose)
    func getProfile()
}

protocol ProvicePurposeRemoteDataManagerOutputProtocol {
    func didProvicePurposeSuccess()
    func didProvicePurposeFail(_ code: Int)
}
