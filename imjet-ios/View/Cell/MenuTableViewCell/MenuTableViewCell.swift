//
//  MenuTableViewCell.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 9/24/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import UIKit

class MenuTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlet
    @IBOutlet weak var nameLb: UILabel!
    
    // MARK: - Properties
    var info: [String: AnyObject]! {
        didSet {
            didSetInfo()
        }
    }
    
    // MARK: - Nib Name
    class func getIdentifier() -> String {
        return "MenuTableViewCell"
    }
    
    // MARK: - View LyfiCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        
    }
    
    // MARK: - DidSet
    func didSetInfo() {
        var nameStr: String = ""
        if let name = info["name"] as? String {
            nameStr = name
        }
        nameLb.text = nameStr
    }
}
