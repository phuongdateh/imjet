//
//  ProvicePurposeInteractorProtocol.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 9/21/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

protocol ProvicePurposeInteractorInputProtocol: class {
    var presenter: ProvicePurposeInteractorOutputProtocol? { get set }
    var remoteDataManager: ProvicePurposeRemoteDataManagerInputProtocol? { get set }
    
    func provicePurpose(_ purpose: UserPurpose)
    func getProfile()
}

protocol ProvicePurposeInteractorOutputProtocol: class {
    func didProvicePurposeSuccess()
    func didProvicePurposeFail(_ code: Int)
}
