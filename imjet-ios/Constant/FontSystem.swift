//
//  FontSystem.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 12/4/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import UIKit

struct FontSystem {
    /// PageTitle , 30
    static let pageTitle: UIFont = UIFont.init(titleFont: .bold, size: 30)!
    /// Section Title, 16
    static let sectionTitle: UIFont = UIFont.init(titleFont: .bold, size: 16)!
    /// Sub Section Title, 10
    static let subSectionTitle: UIFont = UIFont.init(titleFont: .bold, size: 10)!
    /// Normal Text, 14
    static let normalText: UIFont = UIFont.init(defaultFontType: .regular, size: 14)!
    /// Medium Text Montserat, 14
    static let mediumText: UIFont = UIFont.init(titleFont: .medium, size: 14)!
    /// Button, 14
    static let buttonTitle: UIFont = UIFont.init(titleFont: .bold, size: 14)!
}
