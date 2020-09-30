//
//  InputVerifyCodeWireFrame.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 9/14/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

class InputVerifyCodeWireFrame: InputVerifyCodeWireFrameProtocol {
    static func createInputVerifyCodeViewController(verificationId: String, _ phoneNumber: String) -> InputVerifyCodeViewController? {
        if let vc = InputVerifyCodeViewController.initWithStoryboard() as? InputVerifyCodeViewController {
            let presenter = InputVerifyCodePresenter()
            let wireFrame = InputVerifyCodeWireFrame()
            
            vc.phoneNumber = phoneNumber
            vc.verificationId = verificationId
            vc.presenter = presenter
            presenter.wireFrame = wireFrame
            presenter.view = vc
            
            return vc
        }
        return nil
    }
    
    func pushSearchAddress(from view: InputVerifyCodeViewProtocol, builder: JourneyRequestBuilder) {
        
    }
    
    func pushRegister(_ phoneNumber: String, from view: InputVerifyCodeViewProtocol) {
        if let vc = RegisterWireFrame.createRegisterViewController(phoneNumber: phoneNumber), let view = view as? InputVerifyCodeViewController, let navigationController = view.navigationController {
            navigationController.pushViewController(vc, animated: true)
        }
    }
}
