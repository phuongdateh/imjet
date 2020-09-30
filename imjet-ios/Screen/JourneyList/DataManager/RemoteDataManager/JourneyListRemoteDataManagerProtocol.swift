//
//  JourneyListRemoteDataManagerInputProtocol.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 11/15/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

protocol JourneyListRemoteDataManagerInputProtocol: class {
    var remoteRequestHandler: JourneyListRemoteDataManagerOutputProtocol? { get set }
    
    func getCurrentJourneyList()
    func loadMoreCurrentJourney()
    func getHistoryJourneyList()
    func loadMoreHistoryJourneyList()
}

protocol JourneyListRemoteDataManagerOutputProtocol: class {
    func didGetCurrentJourneyListSuccess()
    func didGetCurrentJourneyListFail()
    func didGetHistoryJourneyListSuccess()
    func didGetHistoryJourneyListFail()
    func didLoadMoreCurrentJourneyListSuccess()
    func didLoadMoreCurrentJourneyListFail()
    func didLoadMoreHistoryJourneyListSuccess()
    func didLoadMoreHistoryJourneyListFail()
}
