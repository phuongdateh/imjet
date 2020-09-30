//
//  NotificationService.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 11/21/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import UserNotifications
import UIKit

enum NotificationJourneyAction: String {
    case detail = "journey_match"
    case cancel = "journey_cancel"
    case alarm = "journey_alarm"
    case cancelByAdmin = "journey_cancel_by_admin"
}


class NotificationService {
    static let sharedInstance: NotificationService = {
        return NotificationService()
    }()
    
    func handleNotification(info: [AnyHashable: Any]) {
        guard let data = info["data"] as? String else { return }
        do {
            guard let json = try JSONSerialization.jsonObject(with: Data(data.utf8), options: []) as? [String: Any] else { return }
            guard let action = json["action"] as? String else { return }
            if action == NotificationJourneyAction.detail.rawValue {
                // goto Detail
                if let journeyId = json["objectID"] as? Int {
                    navigateJourneyDetail(journeyId: journeyId)
                }
            }
            else if action == NotificationJourneyAction.alarm.rawValue {
                // goto Detai
                if let journeyId = json["objectID"] as? Int {
                    navigateJourneyDetail(journeyId: journeyId)
                }
            }
            else if action == NotificationJourneyAction.cancel.rawValue {
                // goto Detail
            }
            else {
               // goto Detail
                if let journeyId = json["objectID"] as? Int {
                    navigateJourneyDetail(journeyId: journeyId)
                }
            }
            
        }
        catch {
        }
    }
    
    func navigateJourneyDetail(journeyId: Int) {
        if let vc = JourneyDetailWireFrame.createJourneyDetailViewController(journeyId),
            let topMostVC = ViewService.findTopMostViewController() {
            if let navigationController = topMostVC as? UINavigationController,
                navigationController.viewControllers.count > 0 {
//                let nav = MainNavigationController.init(rootViewController: vc)
//                topMostVC.customPresent(nav, animated: true, completion: nil)
            }
            else {
                let nav = MainNavigationController.init(rootViewController: vc)
                topMostVC.customPresent(nav, animated: true, completion: nil)
            }
        }
    }
}
