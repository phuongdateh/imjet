//
//  CurrentLocationCollectionViewCell.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 12/8/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import UIKit

class CurrentLocationCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var titleLb: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 10
        addShadow()
    }
    
    
}
