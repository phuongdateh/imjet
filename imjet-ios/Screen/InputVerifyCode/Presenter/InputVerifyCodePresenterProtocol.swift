//
//  InputVerifyCodePresenterProtocol.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 9/14/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

protocol InputVerifyCodePresenterProtocol: class {
    var view: InputVerifyCodeViewProtocol? { get set }
    var wireFrame: InputVerifyCodeWireFrameProtocol? { get set }
    
    func pushSearchAddress(builder: JourneyRequestBuilder)
    func pushRegister(_ phoneNumber: String)
    
}
