//
//  RegisterViewProtocol.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 9/10/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

protocol RegisterViewProtocol: class {
    var presenter: RegisterPresenterProtocol? { get set }
    
    func didSendRequestSuccess()
    func didSendRequestFail()
}
