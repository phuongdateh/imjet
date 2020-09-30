//
//  AddressResultsTableViewCell.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 10/18/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import UIKit

class AddressResultsTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlet
    @IBOutlet weak var iconAddressImageView: UIImageView!
    @IBOutlet weak var shortAddressLb: UILabel!
    @IBOutlet weak var longAddressLb: UILabel!
    @IBOutlet weak var lineWrapperView: UIView!
    
    // MARK: - Properties
    var place: GooglePlace! {
        didSet {
            didSetPlace()
        }
    }
    
    // MARK: - Identifier
    class func getIdentifier() -> String {
        return "AddressResultsTableViewCell"
    }
    
    // MARK: - Life Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        lineWrapperView.backgroundColor = ColorSystem.blackOpacity
    }
    
    // MARK: - Method
    func setupData(_ place: GooglePlace) {
        self.place = place
    }
    
    func didSetPlace() {
        var longAddressStr: String = ""
        var shortAddressStr: String = ""
        if let longAddress = place.description {
            longAddressStr = longAddress
            
            if let structuredFormatting = place.structuredFormatting, let shortAddress = structuredFormatting.mainText {
                shortAddressStr = shortAddress
            }
        }
        
        shortAddressLb.text = shortAddressStr
        longAddressLb.text = longAddressStr
    }
}
