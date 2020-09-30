//
//  LoginWireFrame.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 8/27/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import UIKit

class LoginWireFrame: LoginWireFrameProtocol {
    static func createLoginViewController() -> LoginViewController? {
        if let vc = LoginViewController.initWithStoryboard() as? LoginViewController {
            let presenter = LoginPresenter()
            let wireFrame = LoginWireFrame()
            let interactor = LoginInteractor()
            let remoteDataManager = LoginRemoteDataManager()
            
            vc.presenter = presenter
            presenter.view = vc
            presenter.wireFrame = wireFrame
            presenter.interactor = interactor
            interactor.presenter = presenter
            interactor.remoteDataManager = remoteDataManager
            remoteDataManager.remoteRequestHandler = interactor
            
            return vc
        }
        return nil
    }
    
    func pushInputPhoneNumber(from view: LoginViewProtocol) {
        if let vc = InputPhoneNumberWireFrame.createInputPhoneNumberViewController(), let view = view as? LoginViewController, let navigationController = view.navigationController {
            navigationController.pushViewController(vc, animated: true)
        }
    }
}
