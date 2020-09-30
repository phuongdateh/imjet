//
//  Asset.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 8/26/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import UIKit

public enum AssetIdentifier: String {
    
    case logo = "logo"
    case cross = "cross"
    case back_arrow = "back_arrow"
    case hamberger_menu = "hamberger_menu"
    case password_icon = "password_icon"
    case phone_number_icon = "phone_number_icon"
    case signup_facebook = "signup_facebook"
    case signup_google = "signup_google"
    case current_location_icon = "current_location_icon"
    case destination_icon = "destination_icon"
    case iconDriverHome = "imjet_icon_driver_home"
    case iconUserHome = "imjet_icon_user_home"
    case iconOrderTabbar = "order_icon_tabbar"
    case iconProfileTabbar = "profile_icon_tabbar"
    case iconNotificationTabbar = "notification_icon_tabbar"
    case iconHomeTabbar = "home_icon_tabbar"
    case iconSourceUser = "source_user_icon"
    case iconSourceDriver = "source_driver_icon"
    case currentLocationBlackIcon = "current_location_icon_black"
    case currentLocationWhiteIcon = "current_location_icon_white"
    case helmetIcon = "review_journey_helmet_icon"
    case priceIcon = "review_journey_price_icon"
    case motobikeIcon = "review_journey_motobike_icon"
    case helmetChooseIcon = "review_journey_choose_helmet_icon"
    case departureTimeIcon = "review_journey_departuretiem_icon"
    case departureTimeEditIcon = "review_journey_edit_icon"
    case errorNonHelmetIcon = "review_journey_non_helmet_icon"
    case registerPasswordIcon = "register_password_icon"
    case ratingFilled = "rating_filled"
    case ratingEmpty = "rating_empty"
}

extension AssetIdentifier {
    public var value: UIImage? {
        return UIImage()
    }
}

public extension UIImage {
    convenience init? (assetId: AssetIdentifier) {
        self.init(named: assetId.rawValue)
    }
}

public extension UIImageView {
    convenience init? (assetId: AssetIdentifier) {
        self.init(image: UIImage(assetId: assetId))
    }
}

