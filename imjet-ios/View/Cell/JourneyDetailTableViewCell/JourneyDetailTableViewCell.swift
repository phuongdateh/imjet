//
//  JourneyDetailTableViewCell.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 12/24/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import UIKit

enum SearchJourneyStatus: String {
    case searching = "searching"
    case assigning = "assigning"
    case cancelled = "cancelled"
}

class JourneyDetailTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlet
    @IBOutlet weak var titleLb: UILabel!
    @IBOutlet weak var valueLb: UILabel!
    
    @IBOutlet weak var iconWrapperViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var iconImageView: UIImageView!
    
    
    // MARK: - Properties
    var info: [String: AnyObject]! {
        didSet {
            didSetInfo()
        }
    }
    
    // MARK: - Identifier
    class func getIdentifier() -> String {
        return "JourneyDetailTableViewCell"
    }
    
    // MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
        
    }
    
    // MARK: - Method
    func didSetInfo() {
        var titleStr = ""
        var valueStr = ""
        if let userTitle = info["title"] as? String {
            titleStr = userTitle
            if userTitle == "user" {
                iconWrapperViewWidthConstraint.constant = 40
                if let journey = info["value"] as? Journey {
                    guard let userPurpose = journey.userPurpose else { return }
                    guard let status = journey.status else { return }
                    
                    if userPurpose == PurposeType.helmetUser.rawValue || userPurpose == PurposeType.nonHelmetUser.rawValue {
                        iconImageView.setImage(assetId: .iconUserHome)
                        titleStr = "KHÁCH HÀNG"
                    }
                    else {
                        iconImageView.setImage(assetId: .iconDriverHome)
                        titleStr = "TÀI XẾ"
                    }
                    
                    if status == SearchJourneyStatus.searching.rawValue {
                        iconWrapperViewWidthConstraint.constant = 0
                        valueStr = "Đang tìm kiếm."
                    }
                    else if status == SearchJourneyStatus.assigning.rawValue || status == SearchJourneyStatus.cancelled.rawValue {
                        valueStr = journey.getUsernamePartner()
                        if valueStr.count == 0 {
                            valueStr = "Chưa xác định"
                            valueLb.textColor = ColorSystem.blackOpacity
                        }
                    }
                    
                }
            }
            else {
                iconWrapperViewWidthConstraint.constant = 0
            }
        }
        titleLb.text = titleStr
        
        
        if let value = info["value"] as? String {
            valueStr = value
        }
        
        valueLb.text = valueStr
    }
}
