//
//  ProfileWireFrame.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 9/22/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

class ProfileWireFrame: ProfileWireFrameProtocol {
    static func createProfileViewController() -> ProfileViewController? {
        if let vc = ProfileViewController.initWithStoryboard() as? ProfileViewController {
            let wireFrame = ProfileWireFrame()
            let presenter = ProfilePresenter()
            let interactor = ProfileInteractor()
            let remoteDataManager = ProfileRemoteDataManager()
            let localDataManager = ProfileLocalDataManager()
            
            vc.presenter = presenter
            presenter.view = vc
            presenter.interactor = interactor
            presenter.wireFrame = wireFrame
            interactor.localDataManager = localDataManager
            interactor.remoteDataManager = remoteDataManager
            interactor.presenter = presenter
            remoteDataManager.remoteRequestHandler = interactor
            
            return vc
        }
        return nil
    }
}
