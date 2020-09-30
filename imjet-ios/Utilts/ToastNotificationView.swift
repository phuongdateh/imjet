//
//  ToastNotificationView.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 11/26/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import UIKit

class ToastNotificationView: UIView {
    static let sharedInstance: ToastNotificationView = {
        let view = ToastNotificationView.init(frame: CGRect.init(x: 10, y: -30, width: 0, height: 0))
        return view
    }()
    
    private var label: UILabel!
    private var  isShowed: Bool = false
    var notificationInfo: [AnyHashable: Any]! {
        didSet {
            didSetNotificationInfo()
        }
    }
    private var lastSetNotificaitonInfo: Date?
    
    override class func awakeFromNib() {
        
    }
    
    func didSetNotificationInfo() {
        lastSetNotificaitonInfo = Date()
        addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(tap(_:))))
        addGestureRecognizer(UIPanGestureRecognizer.init(target: self, action: #selector(pan(_:))))
        
        backgroundColor = .white
        isUserInteractionEnabled = true
        layer.cornerRadius = 5
        layer.masksToBounds = true
        frame.size.width = ViewService.screenSize().width - 20
        
        if label == nil {
            label = UILabel.init(frame: CGRect.init(x: 15, y: 15, width: frame.width - 30, height: 10))
            label.numberOfLines = 0
            label.setFontAndTextColor(fontType: .regular, size: 14, color: UIColor.init(0x101010))
        }
        
        var contentStr: String = ""
        if let aps = notificationInfo["aps"] as? [String:AnyObject] {
            if let alert = aps["alert"] as? String {
                contentStr = alert
            }
            else if let alert = aps["alert"] as? [String:Any],
                let body = alert["body"] as? String {
                contentStr = body
            }
        }
        
        //
//        guard let data = notificationInfo["data"] as? String else { return }
//        do {
//            guard let json = try JSONSerialization.jsonObject(with: Data(data.utf8), options: []) as? [String: Any] else {
//                return
//
//            }
//
//            if let action = json["action"] {
//                print(action)
//            }
//            if let objectID = json["objectID"] as? Int {
//                NotificationService.sharedInstance.navigateJourneyDetail(journeyId: objectID)
//            }
//        }
//        catch {
//
//
//        }
        
        
        label.text = contentStr
        label.frame.size.height = label.heightOfLabel()
        addSubview(label)
        frame.size.height = 30 + label.heightOfLabel()
        if isShowed == false {
            frame.origin.y = 0 - label.frame.height
        }
        addShadowToOneSide(verticalDirection: .bottom) //remove shadow
        DispatchQueue.main.asyncAfter(deadline: .now() + 3, execute: {[weak self] in
            if let weakSelf = self {
                if weakSelf.lastSetNotificaitonInfo == nil {
                    weakSelf.dismiss()
                }
                else {
                    if Date().timeIntervalSince(weakSelf.lastSetNotificaitonInfo!) >= 3 {
                        Log.info("LastNotificationInfo: \(Date().timeIntervalSince(weakSelf.lastSetNotificaitonInfo!))")
                        weakSelf.dismiss()
                    }
                }
            }
        })
    }
    
    @objc private func tap(_ recognizer: UITapGestureRecognizer) {
        dismiss()
        // Handler notification
//        NotificationService.sharedInstance.handleNotification(info: notificationInfo)
    }
    
    @objc private func pan(_ recogniner: UITapGestureRecognizer) {
        dismiss()
    }
    
    private func  dismiss() {
        UIView.animate(withDuration: 0.3, animations: {[weak self] in
            if let weakSelf = self {
                weakSelf.frame.origin.y = 0 - weakSelf.frame.height
            }
        }) {[weak self](isCompleted) in
            if isCompleted == true {
                if let weakSelf = self {
                    weakSelf.removeFromSuperview()
                }
            }
        }
        isShowed = false
    }
    
    func show(with notificationInfo: [AnyHashable: Any]) {
        self.notificationInfo = notificationInfo
        if isShowed == false {
            let window = UIApplication.shared.keyWindow!
            window.addSubview(self)
            UIView.animate(withDuration: 0.3, animations: {[weak self] in
                if let weakSelf = self {
                    weakSelf.frame.origin.y = 30
                }
            })
            isShowed = true
        }
    }
}



