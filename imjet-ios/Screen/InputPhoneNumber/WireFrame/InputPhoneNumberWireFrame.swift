//
//  InputPhoneNumberWireFrame.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 9/12/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

class InputPhoneNumberWireFrame: InputPhoneNumberWireFrameProtocol {
    static func createInputPhoneNumberViewController() -> InputPhoneNumberViewController? {
        if let vc = InputPhoneNumberViewController.initWithStoryboard() as? InputPhoneNumberViewController {
            let wireFrame = InputPhoneNumberWireFrame()
            let presenter = InputPhoneNumberPresenter()
            let interactor = InputPhoneNumberInteractor()
            let remoteDataManager = InputPhoneNumberRemoteDataManager()
            
            vc.presenter = presenter
            presenter.interactor = interactor
            presenter.view = vc
            presenter.wireFrame = wireFrame
            interactor.remoteDataManager = remoteDataManager
            interactor.presenter = presenter
            remoteDataManager.remoteRequestHandler = interactor
            
            
            return vc
        }
        
        return nil
    }
    
    func pushInputCode(from view: InputPhoneNumberViewProtocol, _ verificationId: String, _ phoneNumer: String) {
        if let vc = InputVerifyCodeWireFrame.createInputVerifyCodeViewController(verificationId: verificationId, phoneNumer), let view = view as? InputPhoneNumberViewController, let navigationController = view.navigationController {
            navigationController.pushViewController(vc, animated: true)
        }
    }
    
    func pushRegister(from view: InputPhoneNumberViewProtocol, _ phoneNumber: String) {
        if let vc = RegisterWireFrame.createRegisterViewController(phoneNumber: phoneNumber), let view = view as? InputPhoneNumberViewController, let navigationController = view.navigationController {
            navigationController.pushViewController(vc, animated: true)
        }
    }
}
