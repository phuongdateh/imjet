//
//  ProfilePresenter.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 9/21/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import RealmSwift

class ProfilePresenter: ProfilePresenterProtocol {
    weak var view: ProfileViewProtocol?
    var interactor: ProfileInteractorInputProtocol?
    var wireFrame: ProfileWireFrameProtocol?
    
    var user: User?
    
    func viewDidLoad() {
        if let interactor = interactor {
            interactor.initUser()
        }
        if let view = view {
            view.beginLoading()
        }
    }
    
    func reloadData() {
        if let interactor = interactor {
            interactor.getUser()
        }
    }
}

extension ProfilePresenter: ProfileInteractorOutputProtocol {
    func didInitUser(user: User?) {
        self.user = user
        if let user = user, let interactor = interactor {
            interactor.registerChange(user: user)
        }
        
        if let view = view {
            view.updateView()
        }
    }
    
    func didReceiveChange(userChange: ObjectChange) {
        if let view = view {
            view.updateView()
        }
    }
    
    func didGetUserSuccess() {
        if let view = view {
            view.stopLoading()
        }
        if self.user == nil {
            if let interactor = interactor {
                interactor.initUser()
            }
        }
    }
    
    func didGetUserFail() {
        if let view = view {
            view.stopLoading()
        }
    }

}
