//
//  OrderListTableViewCell.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 11/16/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import UIKit

class JourneyListTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlet
    @IBOutlet weak var iconPurposeImageView: UIImageView!
    @IBOutlet weak var destinationAddressLb: UILabel!
    @IBOutlet weak var timeLb: UILabel!
    @IBOutlet weak var totalFeeLb: UILabel!
    
    
    // MARK: - Properties
    var journey: Journey?
    var state: JourneyListState!
    
    // MARK: - Identifier
    class func getIdentifier() -> String {
        return "JourneyListTableViewCell"
    }
    
    // MARK: - View Lyfe cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
    
        setupView()
    }
    
    func setupView() {
        iconPurposeImageView.layer.cornerRadius = iconPurposeImageView.frame.size.width/2
        iconPurposeImageView.contentMode = .scaleAspectFit
        
        totalFeeLb.font = FontSystem.sectionTitle
        selectionStyle = .none
    }
    
    func setupData(_ journey: Journey,_ state: JourneyListState) {
        self.journey = journey
        self.state = state
        didSetupData()
    }
    
    func didSetupData() {
        if let journey = journey, journey.isInvalidated == false {
            var destinaionStr: String = ""
            if let googleDirection = journey.googleDirection {
                if let routes = googleDirection.routesList,routes.count > 0, let legs = routes[0].legs,
                legs.count > 0 {
                    if let endAddress = legs[0].endAddress {
                        destinaionStr = endAddress
                    }
                }
            }
            
            // default text color
            totalFeeLb.textColor = ColorSystem.black
            timeLb.textColor = ColorSystem.black
            destinationAddressLb.text = "Đi \(destinaionStr)"
            if let totalFeeStr = (journey.totalFee as NSNumber).asCurrencyString() {
                totalFeeLb.text = totalFeeStr
            }
            if let status = journey.status {
                handleDisplayTime(journey.departureTimestamp, status)
            }
            renderColorText()
        }
    }
    
    func renderColorText() {
        if let journey = journey {
            if let purpose = journey.userPurpose {
                if purpose == PurposeType.helmetUser.rawValue || purpose == PurposeType.nonHelmetUser.rawValue {
                    iconPurposeImageView.setImage(assetId: .iconUserHome)
                }
                else {
                    iconPurposeImageView.setImage(assetId: .iconDriverHome)
                }
            }

            if state == .current {
                timeLb.textColor = ColorSystem.green // green
                if let status = journey.status,
                status == SearchJourneyStatus.searching.rawValue {
                    timeLb.textColor = ColorSystem.blackOpacity
                }
                
            }
            else {
                var totalFeeStr: String = ""
                if let totalFee = (journey.totalFee as NSNumber).asCurrencyString() {
                    totalFeeStr = totalFee
                }
                
                if let status = journey.status {
                    if status == SearchJourneyStatus.cancelled.rawValue {
                        totalFeeLb.text = "ĐÃ HUỶ"
                        totalFeeLb.textColor = ColorSystem.lightGray
                    }
                    else {
                        if let purpose = journey.userPurpose {
                            if purpose == PurposeType.helmetUser.rawValue || purpose == PurposeType.nonHelmetUser.rawValue {
                                totalFeeLb.textColor = ColorSystem.red // red
                                totalFeeLb.text = "- \(totalFeeStr)"
                            }
                            else {
                                totalFeeLb.textColor = ColorSystem.green // green
                                totalFeeLb.text = "+ \(totalFeeStr)"
                            }
                        }
                    }
                }
                
                if let date = journey.departureTimestamp.asDate() {
                    let dateStr = date.asString(format: .dayMonthYear)
                    timeLb.text = dateStr
                    timeLb.textColor = ColorSystem.blackOpacity
                }
                
                
            }
        }
    }
    
    func handleDisplayTime(_ departureTimestamp: Int,_ status: String) {
        let nowTimestamp = Int(Date().timeIntervalSince1970)
        var timeStr: String = ""
        let deltaTime = departureTimestamp - nowTimestamp
        
        if status == SearchJourneyStatus.searching.rawValue {
            timeStr = "Đang tìm kiếm ... "
        }
        else if deltaTime < 0 {
            if let date = departureTimestamp.asDate() {
                timeStr = date.asString(format: .hourDayMonthYear)
            }
        }
        else if deltaTime > 0 && deltaTime < 3600 {
            let minuteStr: String = String((deltaTime % 3600) / 60)
            timeStr = "\(minuteStr) phút nữa."
        }
        else if deltaTime > 3600 || status == "assigning" {
            if let date = departureTimestamp.asDate() {
                timeStr = date.asString(format: .hourDayMonthYear)
            }
        }
        
        timeLb.text = timeStr
    }
    
    
}
