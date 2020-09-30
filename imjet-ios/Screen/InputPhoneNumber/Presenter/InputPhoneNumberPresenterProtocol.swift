//
//  InputPhoneNumberPresenterProtocol.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 9/12/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

protocol InputPhoneNumberPresenterProtocol: class {
    var wireFrame: InputPhoneNumberWireFrameProtocol? { get set }
    var view: InputPhoneNumberViewProtocol? { get set }
    var interactor: InputPhoneNumberInteractorInputProtocol? { get set }
    
    func verifyPhone(phone: VerifyPhone)
    func pushInputCode(_ verificationId: String, _ phoneNumber: String)
    func pushRegister(_ phoneNumber: String)
}
