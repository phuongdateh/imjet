//
//  InputVerifyCodeWireFrameProtocol.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 9/14/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

protocol InputVerifyCodeWireFrameProtocol: class {
    static func createInputVerifyCodeViewController(verificationId: String, _ phoneNumber: String) -> InputVerifyCodeViewController?
    
    func pushSearchAddress(from view: InputVerifyCodeViewProtocol, builder: JourneyRequestBuilder)
    func pushRegister(_ phoneNumber: String, from view: InputVerifyCodeViewProtocol)
}
