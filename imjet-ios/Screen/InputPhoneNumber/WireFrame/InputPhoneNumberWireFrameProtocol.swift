//
//  InputPhoneNumberWireFrameProtocol.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 9/12/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

protocol InputPhoneNumberWireFrameProtocol: class {
    static func createInputPhoneNumberViewController() -> InputPhoneNumberViewController?
    
    func pushInputCode(from view: InputPhoneNumberViewProtocol,_ verificationId: String, _ phoneNumber: String)
    func pushRegister(from view: InputPhoneNumberViewProtocol,_ phoneNumber: String)
}
