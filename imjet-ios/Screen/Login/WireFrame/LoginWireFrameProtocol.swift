//
//  LoginWireFrameProtocol.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 8/27/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import UIKit

protocol LoginWireFrameProtocol: class {
    static func createLoginViewController() -> LoginViewController?
    
    func pushInputPhoneNumber(from view: LoginViewProtocol)
}
