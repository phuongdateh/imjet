//
//  ProfilePresenterProtocol.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 9/21/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

protocol ProfilePresenterProtocol: class {
    var wireFrame: ProfileWireFrameProtocol? { get set }
    var view: ProfileViewProtocol? { get set }
    var interactor: ProfileInteractorInputProtocol? { get set }
    
    var user: User? { get set }
    
    func viewDidLoad()
    func reloadData()
}
