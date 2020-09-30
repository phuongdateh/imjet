//
//  ProfileViewProtocol.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 9/21/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

protocol ProfileViewProtocol: class {
    var presenter: ProfilePresenterProtocol? { get set }
    
    func beginLoading()
    func stopLoading()
    func updateView()
}
