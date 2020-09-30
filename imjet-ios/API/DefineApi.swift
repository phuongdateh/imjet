//
//  LoginApi.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 8/26/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import CoreLocation

protocol LoginRegister {
    func loginByPhone(_ userLogin: UserLogin, completionHandler: @escaping NetworkCompletionHandler)
    func loginByFacebook(token: String, numberOfTry: Int, completionHandler: @escaping NetworkCompletionHandler)
    func loginByGoogle(token: String, numberOfTry: Int, completionHandler: @escaping NetworkCompletionHandler)
    
    func registerByPhone(_ userRegister: UserRegister, completionHandler: @escaping NetworkCompletionHandler)
    func verifyPhone(_ phone: VerifyPhone, completionHandler: @escaping NetworkCompletionHandler)
}

protocol UserInfo {
    func getProfile(completionHandler: @escaping NetworkCompletionHandler)
    func updateProfile(_ editProfile: EditProfileModel, completionHandler: @escaping NetworkCompletionHandler)
    func provicePurpose(_ purpose: UserPurpose, completionHandler: @escaping NetworkCompletionHandler)
}

protocol GoogleService {
    func getDirection(infoQuery: QueryGoogleModel, completionHandler: @escaping NetworkCompletionHandler)
    func getCurrentAddress(by coordinate: CLLocationCoordinate2D, completionHandler: @escaping NetworkCompletionHandler)
    func getAutocomplete(string: String, completionHandler: @escaping NetworkCompletionHandler)
}

protocol RegisterFCM {
    func loginFCM(notiFCM: NotificationFCM, completionHandler: @escaping NetworkCompletionHandler)
    func logoutFCM(notiFCM: NotificationFCM, completionHandler: @escaping NetworkCompletionHandler)
}

protocol JoureynInfo {
    func createJourney(_ requestBuilder: JourneyRequestBuilder, completionHandler: @escaping NetworkCompletionHandler)
    func getCurrentJourey(completionHandler: @escaping NetworkCompletionHandler)
    func getCurrentGlobalFee(completionHandler: @escaping NetworkCompletionHandler)
    func postGlobalFeeEstimate(_ request: GlobalFeeRequest, completionHandler: @escaping NetworkCompletionHandler)
    func getJoureys(isHistory: Bool, complitionHandler: @escaping NetworkCompletionHandler)
    func reloadJourney(_ journeyId: Int, completionHandler: @escaping NetworkCompletionHandler)
    func cancelJourney(_ journeyId: Int, completionHandler: @escaping NetworkCompletionHandler)
    func ratingJourney(journeyId: Int,rating: Rating, completionHandler: @escaping NetworkCompletionHandler)
}



