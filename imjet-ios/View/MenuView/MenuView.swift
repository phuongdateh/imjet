//
//  MenuView.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 9/20/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import UIKit

class MenuView: View {
    
    // MARK: - Nib Name
    override class func nibName() -> String {
        return "MenuView"
    }
    
    // MARK: - ViewLyfeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundColor = .red
        
    }
}
