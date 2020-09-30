//
//  AlamofireAPIWrapper.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 8/24/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import Alamofire

/**
 Subscribe to these status to know network status
 */
enum NetworkReachableStatus: String {
    /**
     Subscribe to these status to know network status
     */
    case wifi = "Reachable.Wifi"
    /**
     Subscribe to these status to know network status
     */
    case cellular = "Reachable.Cellular"
    /**
     Subscribe to these status to know network status
     */
    case notReachable = "Reachable.notReachable"
    /**
     Subscribe to these status to know network status
     */
    case unknown = "Reachable.unknown"
}

class AlamofireSessionManager: NetworkSessionManager {
    override func createSession() -> AnyObject {
        let sessionManager = Alamofire.SessionManager.default
        sessionManager.session.configuration.httpAdditionalHeaders = self.currentHeaderForRequest()
        sessionManager.session.configuration.timeoutIntervalForRequest = 30
        sessionManager.session.configuration.allowsCellularAccess = true
        sessionManager.session.configuration.httpMaximumConnectionsPerHost = 20
        return sessionManager
    }
    
    override func currentHeaderForRequest() -> [String : String] {
        return super.currentHeaderForRequest()
    }
}

class AlamofireAPIWrapper: NetworkWrapper {
    static let reachabilityManager = NetworkReachabilityManager.init(host: "www.apple.com")
    var sessionManager: NetworkSessionManager = AlamofireSessionManager.init()
    var delegate: NetworkWrapperDelegate?
    
    class func initReachability() {
//        reachabilityManager?.listener = { status in
//            let nc = NotificationCenter.default
//            switch status {
//            case .reachable(NetworkReachabilityManager.ConnectionType.ethernetOrWiFi):
//                nc.post(name:Notification.Name(rawValue:NetworkReachableStatus.wifi.rawValue),
//                        object: nil,
//                        userInfo: nil)
//            case .reachable(NetworkReachabilityManager.ConnectionType.wwan):
//                nc.post(name:Notification.Name(rawValue:NetworkReachableStatus.cellular.rawValue),
//                        object: nil,
//                        userInfo: nil)
//            case .notReachable:
//                nc.post(name:Notification.Name(rawValue:NetworkReachableStatus.notReachable.rawValue),
//                        object: nil,
//                        userInfo: nil)
//            case .unknown:
//                nc.post(name:Notification.Name(rawValue:NetworkReachableStatus.unknown.rawValue),
//                        object: nil,
//                        userInfo: nil)
//            }
//        }
//        reachabilityManager?.startListening()
    }
    
    func cancelRequestOfURL(urlString: String) {
        let session = sessionManager.session as! SessionManager
        session.session.getTasksWithCompletionHandler { (dataTask, uploadTask, downloadTask) in
            dataTask.forEach({ (dataTask) in
                if let request = dataTask.originalRequest, let url = request.url, url.absoluteString == urlString{
                    dataTask.cancel()
                }
            })
            uploadTask.forEach({ (uploadTask) in
                if let request = uploadTask.originalRequest, let url = request.url, url.absoluteString == urlString {
                    uploadTask.cancel()
                }
            })
            downloadTask.forEach({ (downloadTask) in
                if let request = downloadTask.originalRequest, let url = request.url, url.absoluteString == urlString {
                    downloadTask.cancel()
                }
            })
        }
    }
    
    func cancelRequestContainURL(urlString: String) {
        let session = sessionManager.session as! SessionManager
        session.session.getTasksWithCompletionHandler { (dataTask, uploadTask, downloadTask) in
            dataTask.forEach({ (dataTask) in
                if let request = dataTask.originalRequest, let url = request.url, url.absoluteString.contains(urlString) {
                    dataTask.cancel()
                }
            })
            
            uploadTask.forEach({ (uploadTask) in
                if let request = uploadTask.originalRequest, let url = request.url, url.absoluteString.contains(urlString) {
                    uploadTask.cancel()
                }
            })
            
            downloadTask.forEach({ (downloadTask) in
                if let request = downloadTask.originalRequest, let url = request.url, url.absoluteString.contains(urlString) {
                    downloadTask.cancel()
                }
            })
        }
    }
    
    func request(requestType: RequestTaskType, requestURLString: String, parameters: [String : AnyObject]?, additionalHeader: [String : String]?, forAuthenticate: Bool, completionHandler: @escaping NetworkCompletionHandler) {
        let session = sessionManager.session as! SessionManager
        switch requestType {
        case .get:
            session.request(requestURLString, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: additionalHeader).responseString(queue: DispatchQueue.global(qos: .background), encoding: String.Encoding.utf8, completionHandler: {[weak self]response in
                if let weakSelf = self {
                    weakSelf.completionHandleData(response: response, forAuthenticate: forAuthenticate, completionHandler: completionHandler)
                }
            })
        case .post:
            session.request(requestURLString, method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: additionalHeader).responseString(queue: DispatchQueue.global(qos: .background), encoding: String.Encoding.utf8, completionHandler: {[weak self] response in
                if let weakSelf = self {
                    weakSelf.completionHandleData(response: response, forAuthenticate: forAuthenticate, completionHandler: completionHandler)
                }
            })
        case .put:
            session.request(requestURLString, method: .put, parameters: parameters, encoding: JSONEncoding.default, headers: additionalHeader).responseString(queue: DispatchQueue.global(qos: .background), encoding: String.Encoding.utf8, completionHandler: {[weak self] response in
                if let weakSelf = self {
                    weakSelf.completionHandleData(response: response, forAuthenticate: forAuthenticate, completionHandler: completionHandler)
                }
            })
        case .delete:
            session.request(requestURLString, method: .delete, parameters: parameters, encoding: JSONEncoding.default, headers: additionalHeader).responseString(queue: DispatchQueue.global(qos: .background), encoding: String.Encoding.utf8, completionHandler: {[weak self] response in
                if let weakSelf = self {
                    weakSelf.completionHandleData(response: response, forAuthenticate: forAuthenticate, completionHandler: completionHandler)
                }
            })
        }
    }
    
    func download(requestURLString: String, parameters: [String : AnyObject]?, additionalHeaders: [String : String]?, dataType: DataType, completionHandler: @escaping NetworkCompletionHandler) {
        let session = sessionManager.session as! SessionManager
        session.request(requestURLString, method: .get, parameters: parameters, encoding: URLEncoding.default, headers: additionalHeaders).response(completionHandler: {[weak self] response in
            if let weakSelf = self {
                weakSelf.completionHandleData(response: response, dataType: dataType, completionHandler: completionHandler)
            }
        })
    }
    
    func upload(requestURLString: String, parameters: [String : AnyObject]?, imagePathInfos: [[String : String]], additionalHeaders: [String : String]?, method: RequestTaskType, forAuthenticate: Bool, completionHandler: @escaping NetworkCompletionHandler) {
        let session = sessionManager.session as! SessionManager
        var convertedMethod: HTTPMethod = .post
        switch method {
        case .get:
            convertedMethod = .get
        case .post:
            convertedMethod = .post
        case .put:
            convertedMethod = .put
        case .delete:
            convertedMethod = .delete
        }
        session.upload(multipartFormData: { (multipartFromData) in
            if let parameters = parameters {
                for (key, value) in parameters {
                    if let value = value as? String {
                        if let data = value.data(using: String.Encoding.utf8) {
                            multipartFromData.append(data, withName: key)
                        }
                    }
                    else if let value = value as? Dictionary<String, AnyObject> {
                        let data = NSKeyedArchiver.archivedData(withRootObject: value)
                        multipartFromData.append(data, withName: key)
                    }
                    else {
                        let value = String.init(describing: value)
                        if let data = value.data(using: String.Encoding.utf8) {
                            multipartFromData.append(data, withName: key)
                        }
                    }
                }
            }
            self.addImageToMultipartFormData(multipartFormData: multipartFromData, imagePathInfos: imagePathInfos)
        }, usingThreshold: UInt64(), to: requestURLString, method: convertedMethod, headers: additionalHeaders, encodingCompletion: { encodingResult in
            switch encodingResult {
            case .failure(let error):
                let errorData = ErrorData.init(code: 9999, value: error.localizedDescription)
                DispatchQueue.main.async {
                    completionHandler(errorData, nil)
                }
            case .success(request: let upload, streamingFromDisk: _, streamFileURL: _):
                upload.uploadProgress(closure: { (progress) in
                    
                })
                upload.responseString(completionHandler: {(response) in
                    self.completionHandleData(response: response, forAuthenticate: forAuthenticate, completionHandler: completionHandler)
                })
            }
        })
    }
    
    func addImageToMultipartFormData(multipartFormData: Any, imagePathInfos: [[String : String]]) {
        for info in imagePathInfos {
            if let key = info["key"], let path = info["path"] {
                if path.count > 0 {
                    let url = URL(fileURLWithPath: path)
                    var fileName = "imageName"
                    var mimeType = "image/jpeg"
                    if let name = info["fileName"]  {
                        fileName = name
                    }
                    if let type = info["mimeType"] {
                        mimeType = type
                    }
                    let multipartFormData = multipartFormData as! MultipartFormData
                    multipartFormData.append(url, withName: key, fileName: fileName, mimeType: mimeType)
                }
            }
        }
    }
    
    func completionHandleData(response: Any, dataType: DataType, completionHandler: @escaping NetworkCompletionHandler) {
        if let response = response as? DefaultDataResponse {
            if let error = response.error {
                let myError = ErrorData.init(code: 9999, value: error.localizedDescription)
                if let request = response.request, let url = request.url {
                    myError.url = url.absoluteString
                }
                DispatchQueue.main.async {
                    completionHandler(myError, nil)
                }
            }
            else {
                if let responsePackage = response.response, let data = response.data, let request = response.request, let url = request.url {
                    switch dataType {
                    case .data:
                        let responseData = ResponseData.init(code: responsePackage.statusCode, value: data, url: url.absoluteString)
                        DispatchQueue.main.async {
                            completionHandler(nil, responseData)
                        }
                    case .image:
                        if let image = UIImage.init(data: data) {
                            let data = ResponseData.init(code: responsePackage.statusCode, value: image, url: url.absoluteString)
                            DispatchQueue.main.async {
                                completionHandler(nil, data)
                            }
                        }
                        else {
                            let myError = ErrorData.init(code: 9999, value: "Can not convert to image from data")
                            myError.url = url.absoluteString
                            DispatchQueue.main.async {
                                completionHandler(myError, nil)
                            }
                        }
                    case .string:
                        if let string = String.init(data: data, encoding: .utf8) {
                            let data = ResponseData.init(code: responsePackage.statusCode, value: string, url: url.absoluteString)
                            DispatchQueue.main.async {
                                completionHandler(nil, data)
                            }
                        }
                        else {
                            let error = ErrorData.init(code: responsePackage.statusCode, value: "Can not convert to string from data")
                            error.url = url.absoluteString
                            DispatchQueue.main.async {
                                completionHandler(error, nil)
                            }
                        }
                    }
                    
                }
            }
        }
        else if let response = response as? DefaultDownloadResponse {
            if let error = response.error {
                let errorData = ErrorData.init(code: 9999, value: error.localizedDescription)
                if let request = response.request {
                    if let url = request.url {
                        errorData.url = url.absoluteString
                    }
                }
                DispatchQueue.main.async {
                    completionHandler(errorData, nil)
                }
                return
            }
            else {
                if let code = response.response?.statusCode {
                    if code >= 200 && code <= 300 {
                        if let destinationURL = response.destinationURL, let request = response.request, let url = request.url {
                            NetworkManagerUtilities.responseDataAndCodeFrom(destiantionURL: destinationURL, code: code, dataType: dataType, requestURL: url, completionHandler: completionHandler)
                            return
                        }
                        let errorData = ErrorData.init(code: 9999, value: "Somethings went wrong")
                        if let request = response.request, let url = request.url {
                            errorData.url = url.absoluteString
                        }
                        DispatchQueue.main.async {
                            completionHandler(errorData, nil)
                        }
                        return
                    }
                    else {
                        var isSpecificError = false
                        if let delegate = self.delegate {
                            isSpecificError = delegate.handleSpecificError(code: code)
                        }
                        if isSpecificError == false {
                            let errorData = ErrorData.init(code: code, value: "Somthing's wrong")
                            if let request = response.request, let url = request.url {
                                errorData.url = url.absoluteString
                            }
                            DispatchQueue.main.async {
                                completionHandler(errorData, nil)
                            }
                        }
                        return
                    }
                }
            }
        }
    }
    
    func completionHandleData(response: DataResponse<String>, forAuthenticate: Bool, completionHandler: @escaping NetworkCompletionHandler) {
        if let error = response.error {
            let errorData = ErrorData.init(code: 9999, value: error.localizedDescription)
            if let request = response.request, let url = request.url {
                errorData.url = url.absoluteString
            }
            DispatchQueue.main.async {
                completionHandler(errorData, nil)
            }
            return
        }
        else {
//            if let response = response.response, response.statusCode < 502 {
//                if let serverTime = response.allHeaderFields["imjet-server-time"] as? String, let serverTimeValue = Double.init(serverTime) {
//                    let date = Date.init(timeIntervalSince1970: serverTimeValue)
//                }
//            }
            if let code = response.response?.statusCode {
                if code >= 200 && code <= 300 {
                    if let responseStr = response.result.value, let request = response.request, let url = request.url {
                        if let convertedValue = NetworkManagerUtilities.convertalue(value: responseStr) {
                            let responseData = ResponseData.init(code: code, value: convertedValue, url: url.absoluteString)
                            if let delegate = self.delegate {
                                DispatchQueue.main.async {
                                    delegate.preHandlerResponsePackage(responseData, forAuthenticate: forAuthenticate)
                                }
                            }
                            DispatchQueue.main.async {
                                completionHandler(nil, responseData)
                            }
                            return
                        }
                    }
                    let errorData = ErrorData.init(code: 9999, value: "Something went wrong")
                    if let request = response.request, let url = request.url {
                        errorData.url = url.absoluteString
                    }
                    DispatchQueue.main.async {
                        completionHandler(errorData, nil)
                    }
                    return
                }
                else {
                    var isSpecificError: Bool = false
                    if let delegate = self.delegate {
                        isSpecificError = delegate.handleSpecificError(code: code)
                    }
                    if isSpecificError == false {
                        var errorDescription: Any = "Something went wrong"
                        if let responseStr = response.result.value {
                            if let convertValue = NetworkManagerUtilities.convertalue(value: responseStr) {
                                errorDescription = convertValue
                            }
                            else {
                                errorDescription = responseStr
                            }
                        }
                        let errorData = ErrorData.init(code: code, value: errorDescription)
                        if let request = response.request, let url = request.url {
                            errorData.url = url.absoluteString
                        }
                        DispatchQueue.main.async {
                            completionHandler(errorData, nil)
                        }
                    }
                    return
                }
            }
        }
    }
}


