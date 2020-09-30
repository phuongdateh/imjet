//
//  CodeEnum.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 9/14/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

enum CodeEnum: String {
    case SOME_ERROR = "SOME_ERROR"
    case REACH_LIMIT = "REACH_LIMIT"
    case FORBIDDEN = "FORBIDDEN"
    case INTERNAL_SERVER_ERROR = "INTERNAL_SERVER_ERROR"
    case UNAUTHORIZED = "UNAUTHORIZED"
    case BODY_INVALID = "BODY_INVALID"
    case REQUEST_INVALID = "REQUEST_INVALID"
    case PASSWORD_NOT_MATCH = "PASSWORD_NOT_MATCH"
    case COUNTRY_CODE_INVALID = "COUNTRY_CODE_INVALID"
    case PHONE_OR_PASSWORD_INVALID = "PHONE_OR_PASSWORD_INVALID"
    case ACCOUNT_EXIST = "ACCOUNT_EXIST"
    case PHONE_NUMBER_INVALID = "PHONE_NUMBER_INVALID"
    case PHONE_NUMBER_NOT_FOUND = "PHONE_NUMBER_NOT_FOUND"
    case LENGTH_PASSWORD_INVALID = "LENGTH_PASSWORD_INVALID"
    case PHONE_NUMBER_NOT_VERIFIED = "PHONE_NUMBER_NOT_VERIFIED"
    case PHONE_NUMBER_VERIFIED = "PHONE_NUMBER_VERIFIED"
    case SMS_VERIFY_CODE_INVALID = "SMS_VERIFY_CODE_INVALID"
    case TOKEN_INVALID = "TOKEN_INVALID"
    case GENDER_INVALID = "GENDER_INVALID"
    case BIRTHDAY_INVALID = "BIRTHDAY_INVALID"
    case EMAIL_INVALID = "EMAIL_INVALID"
    
    init?(_ code: Int) {
        switch code {
        case 0: self = .SOME_ERROR
        case 1: self = .REACH_LIMIT
        case 2: self = .FORBIDDEN
        case 3: self = .INTERNAL_SERVER_ERROR
        case 4: self = .UNAUTHORIZED
        case 5: self = .BODY_INVALID
        case 6: self = .REQUEST_INVALID
        case 7: self = .PASSWORD_NOT_MATCH
        case 8: self = .COUNTRY_CODE_INVALID
        case 9: self = .PHONE_OR_PASSWORD_INVALID
        case 10: self = .ACCOUNT_EXIST
        case 11: self = .PHONE_NUMBER_INVALID
        case 12: self = .LENGTH_PASSWORD_INVALID
        case 13: self = .PHONE_NUMBER_NOT_VERIFIED
        case 14: self = .PHONE_NUMBER_VERIFIED
        case 15: self = .PHONE_NUMBER_NOT_FOUND
        case 16: self = .SMS_VERIFY_CODE_INVALID
        case 17: self = .TOKEN_INVALID
        case 18: self = .GENDER_INVALID
        case 19: self = .BIRTHDAY_INVALID
        case 20: self = .EMAIL_INVALID
        default: return nil
        }
    }
    
    static func create(_ code: Int) -> String {
        if let codeEnum = CodeEnum.init(code) {
            return codeEnum.rawValue
        }
        else {
            return ""
        }
    }
}


