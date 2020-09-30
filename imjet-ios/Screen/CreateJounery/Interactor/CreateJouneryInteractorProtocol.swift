//
//  CreateJouneryInteractorProtocol.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 10/20/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

protocol CreateJouneryInteractorInputProtocol: class {
    var presenter: CreateJouneryInteractorOutputProtocol? { get set }
    var remoteDataManager: CreateJouneryRemoteDataManagerInputProtocol? { get set }
    
    func getDirection(_ info: QueryGoogleModel)
}

protocol CreateJouneryInteractorOutputProtocol: class {
    func didGetDirectionSuccess(_ infoDirection: GoogleDirection)
    func didGetDirectionFail()
}
