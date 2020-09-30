//
//  InputVerifyCodePresenter.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 9/14/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

class InputVerifyCodePresenter: InputVerifyCodePresenterProtocol {
    weak var view: InputVerifyCodeViewProtocol?
    var wireFrame: InputVerifyCodeWireFrameProtocol?
    
    func pushSearchAddress(builder: JourneyRequestBuilder) {
        if let wireFrame = wireFrame, let view = view {
            wireFrame.pushSearchAddress(from: view, builder: builder)
        }
    }
    
    func pushRegister(_ phoneNumber: String) {
        if let wireFrame = wireFrame, let view = view {
            wireFrame.pushRegister(phoneNumber, from: view)
        }
    }
}
