//
//  ProfileInteractor.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 9/22/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import RealmSwift

class ProfileInteractor: ProfileInteractorInputProtocol {
    weak var presenter: ProfileInteractorOutputProtocol?
    var remoteDataManager: ProfileRemoteDataManagerInputProtocol?
    var localDataManager: ProfileLocalDataManagerProtocol?
    
    var userNotificationToken: NotificationToken?
    
    func getUser() {
        if let remoteDataManager = remoteDataManager {
            remoteDataManager.getUser()
        }
    }
    
    func initUser() {
        if let presenter = presenter, let localDataManager = localDataManager {
            presenter.didInitUser(user: localDataManager.initUser())
        }
    }
    
    deinit {
        if let userNotificationToken = userNotificationToken {
            userNotificationToken.invalidate()
        }
    }
    
    func registerChange(user: User) {
        userNotificationToken = user.observe({[weak self] (change) in
            if let weakSelf = self, let presenter = weakSelf.presenter {
                presenter.didReceiveChange(userChange: change)
            }
        })
    }
}

extension ProfileInteractor: ProfileRemoteDataManagerOutputProtocol {
    func didGetUserSuccess() {
        if let presenter = presenter {
            presenter.didGetUserSuccess()
        }
    }
    
    func didGetUserFail() {
        if let presenter = presenter {
            presenter.didGetUserFail()
        }
    }
}
