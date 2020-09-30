//
//  ProvicePurposeViewProtocol.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 9/21/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

protocol ProvicePurposeViewProtocol: class {
    var presenter: ProvicePurposePresenterProtocol? { get set }
    
    func didProvicePurposeSuccess()
    func didProvicePurposeFail(_ code: Int)
}
