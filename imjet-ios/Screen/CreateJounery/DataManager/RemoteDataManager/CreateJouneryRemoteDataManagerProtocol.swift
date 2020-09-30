//
//  CreateJouneryRemoteDataManagerProtocol.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 10/20/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

protocol CreateJouneryRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: CreateJouneryRemoteDataManagerOutputProtocol? { get set }
    
    func getDirection(_ info: QueryGoogleModel)
}

protocol CreateJouneryRemoteDataManagerOutputProtocol: class {
    func didGetDirectionSuccess(_ infoDirection: GoogleDirection)
    func didGetDirectionFail()
}
