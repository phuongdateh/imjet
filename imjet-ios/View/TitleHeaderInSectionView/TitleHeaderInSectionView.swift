//
//  TitleHeaderInSectionView.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 12/26/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import UIKit

class TitleHeaderInSectionView: UIView {
    
    @IBOutlet weak var sectionTitleLb: UILabel!
    // MARK: - Nibname
    class func nibName() -> String {
        return "TitleHeaderInSectionView"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        sectionTitleLb.font = FontSystem.sectionTitle
        sectionTitleLb.textColor = ColorSystem.blackOpacity
    }
    
    func setupTitle(section: String) {
        sectionTitleLb.text = "Tháng \(section)"
    }
}
