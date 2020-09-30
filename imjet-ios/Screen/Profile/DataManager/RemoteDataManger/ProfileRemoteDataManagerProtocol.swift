//
//  ProfileRemoteDataManagerProtocol.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 9/23/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

protocol ProfileRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: ProfileRemoteDataManagerOutputProtocol? { get set }
    
    func getUser()
}

protocol ProfileRemoteDataManagerOutputProtocol: class {
    func didGetUserSuccess()
    func didGetUserFail()
}
