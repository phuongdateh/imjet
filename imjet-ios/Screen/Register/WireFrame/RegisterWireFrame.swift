//
//  RegisterWireFrame.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 9/10/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

class RegisterWireFrame: RegisterWireFrameProtocol {
    static func createRegisterViewController(phoneNumber: String) -> RegisterViewController? {
        if let vc = RegisterViewController.initWithStoryboard() as? RegisterViewController {
            let presenter = RegisterPresenter()
            let interactor = RegisterInteractor()
            let wireFrame = RegisterWireFrame()
            let remoteDataManager = RegisterRemoteDataManager()
            
            vc.presenter = presenter
            vc.phoneNumber = phoneNumber
            presenter.view = vc
            presenter.interactor = interactor
            presenter.wireFrame = wireFrame
            interactor.presenter = presenter
            interactor.remoteDataManager = remoteDataManager
            remoteDataManager.remoteRequestHandler = interactor
            
            return vc
        }
        return nil
    }
}
