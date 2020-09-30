//
//  RegisterWireFrameProtocol.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 9/10/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

protocol RegisterWireFrameProtocol: class {
    static func createRegisterViewController(phoneNumber: String) -> RegisterViewController?
    
}
