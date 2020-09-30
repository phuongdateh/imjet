//
//  ApiServerConfiguration.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 8/23/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import Alamofire
import CoreLocation

class APIServiceManager: NSObject {
    /// Store configuration setup
    private var serverConfig = ServerConfiguration()
    var networkManager: NetworkManager = NetworkManager()
    
    /// Make APIServcieManager a singleton
    static let sharedInstance: APIServiceManager = {
        var manager = APIServiceManager()
        manager.networkManager.wrapper.delegate = manager
        return manager
    }()
    
    /// Set Authorization from json
    /// - json: response json
    private func setAuthorizationTokenFrom(json: [String: AnyObject]) {
        if let data = json[Constants.kData] as? [String: AnyObject], let token = data[Constants.kAccessToken] as? String {
            UserDefaults.standard.setValue(token, forKey: Constants.kAccessToken)
        }
    }
    
    /**
     Method gets the AskTutor base request URL
     - returns: String
     */
    private func getBaseRequestURL() -> String {
        return serverConfig.baseRequestURL
    }
    
    private func currentURLForRequest(_ endPoint: String, port: PortService) -> String {
        return self.getBaseRequestURL() + "\(port.rawValue)" + "v1/" + endPoint
    }
    
    // Create parameter for request
    func createParameters(_ parameters: [String: AnyObject]?) -> [String: AnyObject] {
        var newParameters: [String: AnyObject] = [:]
        if let parameters = parameters {
            let keys = parameters.keys
            for key in keys {
                newParameters.updateValue(parameters[key]!, forKey: key)
            }
        }
        return newParameters
    }
    
    // Create header for request.
    func currentHeaderForRequest(_ extraHeader: [String: String]?) -> [String: String] {
        var header: [String: String] = [:]
        if let extraHeader = extraHeader {
            header = extraHeader
        }
        if let authorizationToken = getAuthorizationToken() {
            header[Constants.kHeaderAccessToken] = authorizationToken
        }
        header["Content-Type"] = "application/json"
//        header["X-Lozi-Client-Token"] = "30|1572157382.662112e3d17da60e3982bf4c283e47b435c1270b124a3cc9c72af3220d48aad5"
        
        
        return header
    }
    
    // Get AuthorizationToken
    func getAuthorizationToken() -> String? {
        if let token = UserDefaults.standard.object(forKey: Constants.kAccessToken) as? String {
            return token
        }
        return nil
    }
    
    // Make custom request
    func makeCustomRequest(requestType: RequestTaskType, endPoint: String, parameters: [String:AnyObject]? = nil, extraHeaders: [String:String]? = nil, forAuthenticate: Bool = false,port: PortService, completionHandler: @escaping NetworkCompletionHandler) {
        let requestURLString = currentURLForRequest(endPoint, port: port)
        let headers = currentHeaderForRequest(extraHeaders)
        let currentParameters = createParameters(parameters)
        networkManager.wrapper.request(requestType: requestType, requestURLString: requestURLString, parameters: currentParameters, additionalHeader: headers, forAuthenticate: forAuthenticate, completionHandler: completionHandler)
    }
}

// MARK: - NetworkWrapperDelegate
extension APIServiceManager: NetworkWrapperDelegate {
    // Save Token when login
    func preHandlerResponsePackage(_ responsePackage: ResponseData, forAuthenticate: Bool) {
        if let responseData = responsePackage.value as? [String: AnyObject] {
            if forAuthenticate == true {
                setAuthorizationTokenFrom(json: responseData)
            }
        }
    }
    
    /** return true if you don't want to continue after this function
     return false if you want to continue after this function, like throw out error
     */
    func handleSpecificError(code: Int) -> Bool {
        
        if code == 401 {
            DispatchQueue.main.async {
                let nc = NotificationCenter.default
                nc.post(name: Notification.Name(rawValue:"UNAUTHORIZED"),
                        object: nil,
                        userInfo: nil)
            }
        }
        return false
    }
}

// MARK: - LoginRegister
extension APIServiceManager: LoginRegister{
    func loginByPhone(_ userLogin: UserLogin, completionHandler: @escaping NetworkCompletionHandler) {
        if let userRequest = userLogin.asDictionary() {
            let requestURLString: String = currentURLForRequest("auth/phone-number/login", port: .auth)
            
            let headers = currentHeaderForRequest(nil)
            let params = createParameters(userRequest as [String: AnyObject])
            networkManager.wrapper.request(requestType: .post, requestURLString: requestURLString, parameters: params, additionalHeader: headers, forAuthenticate: true, completionHandler: completionHandler)
        }
    }
    
    func loginByFacebook(token: String, numberOfTry: Int = 3, completionHandler: @escaping NetworkCompletionHandler) {
        let requestURLString: String = currentURLForRequest("auth/facebook/login", port: .auth)
        let headers = currentHeaderForRequest(nil)
        let params: [String: AnyObject] = ["token": token as AnyObject]
        networkManager.wrapper.request(requestType: .post, requestURLString: requestURLString, parameters: params, additionalHeader: headers, forAuthenticate: true, completionHandler: { [weak self] (errorPackage, responsePackage) in
            if let errorPackage = errorPackage, let code = errorPackage.code, code > 504, let weakSelf = self, numberOfTry > 0 {
                weakSelf.loginByFacebook(token: token, numberOfTry: numberOfTry - 1, completionHandler: completionHandler)
            }
            else {
                completionHandler(errorPackage, responsePackage)
            }
        })
    }
    
    func loginByGoogle(token: String, numberOfTry: Int = 3,completionHandler: @escaping NetworkCompletionHandler) {
        let requestURLString: String = currentURLForRequest("auth/google/login", port: .auth)
        let headers = currentHeaderForRequest(nil)
        let params: [String: AnyObject] = ["token" : token as AnyObject]
        networkManager.wrapper.request(requestType: .post, requestURLString: requestURLString, parameters: params, additionalHeader: headers, forAuthenticate: true, completionHandler: { [weak self] (errorPackage, responsePackage) in
            if let errorPackage = errorPackage, let code = errorPackage.code, code > 504, let weakSelf = self, numberOfTry > 0 {
                weakSelf.loginByGoogle(token: token, numberOfTry: numberOfTry - 1, completionHandler: completionHandler)
            }
            else {
                completionHandler(errorPackage, responsePackage)
            }
        })
    }
    
    func registerByPhone(_ userRegister: UserRegister, completionHandler: @escaping NetworkCompletionHandler) {
        if let userRequest = userRegister.asDictionary() {
            let requestURLString: String = currentURLForRequest("auth/phone-number/register", port: .auth)
            let headers = currentHeaderForRequest(nil)
            let params = createParameters(userRequest as [String: AnyObject])
            networkManager.wrapper.request(requestType: .post, requestURLString: requestURLString, parameters: params, additionalHeader: headers, forAuthenticate: true, completionHandler: completionHandler)
        }
    }
    
    func verifyPhone(_ phone: VerifyPhone, completionHandler: @escaping NetworkCompletionHandler) {
        if let request = phone.asDictionary() {
            let requestURLString: String = currentURLForRequest("auth/phone-number/verify", port: .auth)
            let headers = currentHeaderForRequest(nil)
            let params = createParameters(request as [String: AnyObject])
            networkManager.wrapper.request(requestType: .post, requestURLString: requestURLString, parameters: params, additionalHeader: headers, forAuthenticate: false, completionHandler: completionHandler)
        }
    }
}

// MARK: Profile
extension APIServiceManager: UserInfo {
    func getProfile(completionHandler: @escaping NetworkCompletionHandler) {
        let requestURLString: String = currentURLForRequest("users/me/profiles", port: .core)
        let headers = currentHeaderForRequest(nil)
        let params = createParameters(nil)
        networkManager.wrapper.request(requestType: .get, requestURLString: requestURLString, parameters: params, additionalHeader: headers, forAuthenticate: false, completionHandler: completionHandler)
    }
    
    func provicePurpose(_ purpose: UserPurpose, completionHandler: @escaping NetworkCompletionHandler) {
        if let request = purpose.asDictionary() {
            let requestURLString: String = currentURLForRequest("users/me/purpose", port: .core)
            let headers = currentHeaderForRequest(nil)
            let params = request as [String: AnyObject]
            networkManager.wrapper.request(requestType: .put, requestURLString: requestURLString, parameters: params, additionalHeader: headers, forAuthenticate: false, completionHandler: completionHandler)
        }
    }
    
    func updateProfile(_ editProfile: EditProfileModel, completionHandler: @escaping NetworkCompletionHandler) {
        if let request = editProfile.asDictionary() {
            let requestURLString: String = currentURLForRequest("users/me/profiles", port: .core)
            let headers = currentHeaderForRequest(nil)
            let params = createParameters(request as [String: AnyObject])
            networkManager.wrapper.request(requestType: .put, requestURLString: requestURLString, parameters: params, additionalHeader: headers, forAuthenticate: false, completionHandler: completionHandler)
        }
    }
}

// MARK: - GoogleService
extension APIServiceManager: GoogleService {
    func getDirection(infoQuery: QueryGoogleModel, completionHandler: @escaping NetworkCompletionHandler) {
        if let request = infoQuery.asDictionary() {
//            let urlLozi: String = "https://lungo.lozi.vn/v5/maps/api/directions"
            let requestURLString: String = currentURLForRequest("maps/api/directions/json", port: .googleApi)
            
            let headers = currentHeaderForRequest(nil)
            let params = createParameters(request as [String: AnyObject])
            networkManager.wrapper.request(requestType: .get, requestURLString: requestURLString, parameters: params, additionalHeader: headers, forAuthenticate: false, completionHandler: completionHandler)
        }
    }
    
    func getCurrentAddress(by coordinate: CLLocationCoordinate2D, completionHandler: @escaping NetworkCompletionHandler) {
        let requestURLString = currentURLForRequest("maps/api/geocode/json", port: .googleApi)
        let headers = currentHeaderForRequest(nil)
        let params = createParameters(["latlng": "\(coordinate.latitude),\(coordinate.longitude)"] as [String: AnyObject])
        networkManager.wrapper.request(requestType: .get, requestURLString: requestURLString, parameters: params, additionalHeader: headers, forAuthenticate: false, completionHandler: completionHandler)
    }
    
    func getAutocomplete(string: String, completionHandler: @escaping NetworkCompletionHandler) {
        let requestURLString = currentURLForRequest("maps/api/place/autocomplete/json", port: .googleApi)
        let headers = currentHeaderForRequest(nil)
        let params = createParameters(["input": string] as [String: AnyObject])
        networkManager.wrapper.request(requestType: .get, requestURLString: requestURLString, parameters: params, additionalHeader: headers, forAuthenticate: false, completionHandler: completionHandler)
    }
}

// MARK: - RegisterFCM
extension APIServiceManager: RegisterFCM {
    func loginFCM(notiFCM: NotificationFCM, completionHandler: @escaping NetworkCompletionHandler) {
        if let request = notiFCM.asDictionary() {
            let requestURLString = currentURLForRequest("fcm-tokens/login", port: .core)
            let headers = currentHeaderForRequest(nil)
            let params = createParameters(request as [String: AnyObject])
            networkManager.wrapper.request(requestType: .put, requestURLString: requestURLString, parameters: params, additionalHeader: headers, forAuthenticate: false, completionHandler: completionHandler)
        }
        else {
            ToastView.sharedInstance.showContent("Some Error")
        }
    }
    
    func logoutFCM(notiFCM: NotificationFCM, completionHandler: @escaping NetworkCompletionHandler) {
        if let request = notiFCM.asDictionary() {
            let requestURLString = currentURLForRequest("fcm-tokens/logout", port: .core)
            let headers = currentHeaderForRequest(nil)
            let params = createParameters(request as [String: AnyObject])
            networkManager.wrapper.request(requestType: .put, requestURLString: requestURLString, parameters: params, additionalHeader: headers, forAuthenticate: false, completionHandler: completionHandler)
        }
    }
}

// MARK: - JourneyInfo
extension APIServiceManager: JoureynInfo {
    func createJourney(_ requestBuilder: JourneyRequestBuilder, completionHandler: @escaping NetworkCompletionHandler) {
        if let request = requestBuilder.asDictionary() {
            let requestURLString = currentURLForRequest("journeys", port: .core)
            let headers = currentHeaderForRequest(nil)
            let params = createParameters(request as [String: AnyObject])
            networkManager.wrapper.request(requestType: .post, requestURLString: requestURLString, parameters: params, additionalHeader: headers, forAuthenticate: false, completionHandler: completionHandler)
        }
    }
    
    func getCurrentJourey(completionHandler: @escaping NetworkCompletionHandler) {
        let requestURLString = currentURLForRequest("journeys", port: .core)
        let headers = currentHeaderForRequest(nil)
        let params = createParameters(nil)
        networkManager.wrapper.request(requestType: .get, requestURLString: requestURLString, parameters: params, additionalHeader: headers, forAuthenticate: false, completionHandler: completionHandler)
    }
    
    func getCurrentGlobalFee(completionHandler: @escaping NetworkCompletionHandler) {
        let requestURLString = currentURLForRequest("global-fees", port: .core)
        let headers = currentHeaderForRequest(nil)
        let params = createParameters(nil)
        networkManager.wrapper.request(requestType: .get, requestURLString: requestURLString, parameters: params, additionalHeader: headers, forAuthenticate: false, completionHandler: completionHandler)
    }
    
    func postGlobalFeeEstimate(_ request: GlobalFeeRequest, completionHandler: @escaping NetworkCompletionHandler) {
        if let request = request.asDictionary() {
            let requestURLString = currentURLForRequest("global-fees/estimate", port: .core)
            let headers = currentHeaderForRequest(nil)
            let params = createParameters(request as [String: AnyObject])
            networkManager.wrapper.request(requestType: .post, requestURLString: requestURLString, parameters: params, additionalHeader: headers, forAuthenticate: false, completionHandler: completionHandler)
        }
    }
    
    func getJoureys(isHistory: Bool, complitionHandler: @escaping NetworkCompletionHandler) {
        let requestURLString: String = currentURLForRequest("journeys", port: .core)
        var queryParam: [String: AnyObject] = [:]
        if isHistory == false {
            queryParam["isHistory"] = "false" as AnyObject
        }
        else {
            queryParam["isHistory"] = "true" as AnyObject
        }
        let params = createParameters(queryParam)
        let headers = currentHeaderForRequest(nil)
        networkManager.wrapper.request(requestType: .get, requestURLString: requestURLString, parameters: params, additionalHeader: headers, forAuthenticate: false, completionHandler: complitionHandler)
    }
    
    func pushNotification(complitionHandler: @escaping NetworkCompletionHandler)  {
        let requestURLString: String = currentURLForRequest("fcm-tokens/test", port: .core)
        networkManager.wrapper.request(requestType: .post, requestURLString: requestURLString, parameters: nil, additionalHeader: currentHeaderForRequest(nil), forAuthenticate: false, completionHandler: complitionHandler)
    }
    
    func reloadJourney(_ journeyId: Int, completionHandler: @escaping NetworkCompletionHandler) {
        let requestURLString: String = currentURLForRequest("journeys/\(journeyId)", port: .core)
        let header = currentHeaderForRequest(nil)
        let params = createParameters(nil)
        networkManager.wrapper.request(requestType: .get, requestURLString: requestURLString, parameters: params, additionalHeader: header, forAuthenticate: false, completionHandler: completionHandler)
    }
    
    func cancelJourney(_ journeyId: Int, completionHandler: @escaping NetworkCompletionHandler) {
        let requestURLString: String = currentURLForRequest("journeys/\(journeyId)/statuses/cancel", port: .core)
        let header = currentHeaderForRequest(nil)
        let param = createParameters(nil)
        networkManager.wrapper.request(requestType: .put, requestURLString: requestURLString, parameters: param, additionalHeader: header, forAuthenticate: false, completionHandler: completionHandler)
    }
    
    func ratingJourney(journeyId: Int, rating: Rating, completionHandler: @escaping NetworkCompletionHandler) {
        if let request = rating.asDictionary() {
            let requestURLString: String = currentURLForRequest("journeys/\(journeyId)/ratings", port: .core)
            let header = currentHeaderForRequest(nil)
            let params = createParameters(request as [String: AnyObject])
            networkManager.wrapper.request(requestType: .post, requestURLString: requestURLString, parameters: params, additionalHeader: header, forAuthenticate: false, completionHandler: completionHandler)
        }
    }
}
