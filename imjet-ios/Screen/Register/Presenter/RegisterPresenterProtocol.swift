//
//  RegisterPresenterProtocol.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 9/10/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

protocol RegisterPresenterProtocol: class {
    var view: RegisterViewProtocol? { get set }
    var wireFrame: RegisterWireFrameProtocol? { get set }
    var interactor: RegisterInteractorInputProtocol? { get set }
    
    // MARK: - Method
    func sendRequest(_ userRegister: UserRegister)
}
