//
//  ProfileInteractorInputProtocol.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 9/22/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import RealmSwift

protocol ProfileInteractorInputProtocol: class {
    var presenter: ProfileInteractorOutputProtocol? { get set }
    var remoteDataManager: ProfileRemoteDataManagerInputProtocol? { get set }
    var localDataManager: ProfileLocalDataManagerProtocol? { get set }
    
    func getUser()
    func initUser()
    func registerChange(user: User)
}

protocol ProfileInteractorOutputProtocol: class {
    func didInitUser(user: User?)
    func didReceiveChange(userChange: ObjectChange)
    func didGetUserSuccess()
    func didGetUserFail()
}
