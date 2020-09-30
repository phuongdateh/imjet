//
//  View.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 8/22/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import UIKit

class View: UIView {
    
    class func nibName() -> String {
        return ""
    }
    
    class func initWithNib() ->View {
        return ViewService.viewFrom(nibName()) as! View
    }
    
    
    convenience init() {
        self.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0))
        
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
        
    }
    
    deinit {
        // deinit something
        
        
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        
    }
}
