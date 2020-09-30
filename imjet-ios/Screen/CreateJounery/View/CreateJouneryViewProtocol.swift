//
//  CreateJouneryViewProtocol.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 10/20/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

protocol CreateJouneryViewProtocol: class {
    var presenter: CreateJouneryPresenterProtocol? { get set }
    
    func didGetDirectionSuccess(_ infoDirection: GoogleDirection)
    func didGetDirectionFail()
}
