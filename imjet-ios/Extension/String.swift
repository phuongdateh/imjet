//
//  String.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 9/25/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation

enum HyperlinkType {
    case phone
    case email
    case number
}

public extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main, value: "", comment: "")
    }
}

extension String {
    
    func matching(hyperlink type: HyperlinkType) -> Bool {
        if self == "" {
            return false
        }
        let charReg = getPattern(fromType: type)
        let charPredicate = NSPredicate(format: "SELF MATCHES %@", charReg)
        return charPredicate.evaluate(with: self)
    }
    
    private func getPattern(fromType: HyperlinkType) -> String {
        switch fromType {
        
        case .phone:
            return "(\\d{9,12})|(\\d{3,5}(((\\-|\\ )\\d{2,5}){2,3})|\\d{3,4}(\\-|\\ )\\d{6})"
        case .number:
            return "[0-9]+"
        case .email:
            return "[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}"
                + "[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*"
        default:
            return ""
        }
    }
    
    func validate(with type: HyperlinkType) -> Bool{
        let match = matching(hyperlink: type)
        switch type {
        case .email, .number:
            return match && !isEmpty
        case .phone:
            let wrapperPhone = self.standardized(with: .phone)
            return match && wrapperPhone.isValidateVietnamPhoneNumber()
        default:
            return false
        }
    }
    
    func standardized(with type: HyperlinkType) -> String {
        switch type {
        case .phone:
            return replacingOccurrences(of: "-", with: "")
                .replacingOccurrences(of: " ", with: "")
                .replacingOccurrences(of: "(", with: "")
                .replacingOccurrences(of: ")", with: "")
                .replacingOccurrences(of: ",", with: "")
                .replacingOccurrences(of: "+", with: "")
//        case .url:
//            return replacingOccurrences(of: " ", with: "%20")
        default:
            return self
        }
    }
    
    private func isValidateVietnamPhoneNumber() -> Bool {
        let trimPhone = self.trimCountryCode()
        guard trimPhone.utf16.count > 8 else {
            return false
        }
        let firstStart = trimPhone.index(trimPhone.startIndex, offsetBy: 0)
        let firstEnd = trimPhone.index(trimPhone.startIndex, offsetBy: 1)
        let firstChar = String(trimPhone[firstStart..<firstEnd])
        switch firstChar {
        case "8":
            // Home phone
            return trimPhone.count >= 9
        case "1":
            // 01xxx
            return trimPhone.count >= 10
        case "9":
            // 09xxxx
            return trimPhone.count >= 9
        default:
            return false
        }
    }
    
    func isMatchWithRegex(regexStr: String) -> Bool {
        do {
            let regex = try NSRegularExpression.init(pattern: regexStr, options: [])
            if let result = regex.firstMatch(in: self, options: [], range: NSRange.init(location: 0, length: self.count)) {
                let str = String(self[Range(result.range, in: self)!])
                if str == self {
                    return true
                }
                
            }
            return false
        }
        catch {
            return false
        }
    }
    
    func isCorrectPhoneNumberFormat() -> Bool {
        return isMatchWithRegex(regexStr: "^(0|84|840)?\\d{9,10}$")
    }
    
    private func trimCountryCode() -> String {
        guard utf16.count > 7 else {
            return self
        }
        let firstStart = index(startIndex, offsetBy: 0)
        let firstEnd = index(startIndex, offsetBy: 1)
        let twoStart = index(startIndex, offsetBy: 0)
        let twoEnd = index(startIndex, offsetBy: 2)
        let firstChar = String(self[firstStart..<firstEnd])
        let twoChars = String(self[twoStart..<twoEnd])
        if twoChars == "84" {
            let otherStart = index(endIndex, offsetBy: -(count - 2))
            let otherEnd = index(endIndex, offsetBy: 0)
            return String(self[otherStart..<otherEnd])
        }
        if twoChars != "84" && firstChar == "0" {
            let otherStart = index(endIndex, offsetBy: -(count - 1))
            let otherEnd = index(endIndex, offsetBy: 0)
            return String(self[otherStart..<otherEnd])
        }
        return self
    }
    
    /// Get substring
    func getSubString(offsetBy: IndexDistance) -> SubSequence {
        return self[...self.index(self.startIndex, offsetBy: offsetBy - 1)]
    }
    
    
    
    
}
