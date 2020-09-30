//
//  UITableView.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 12/18/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    /**
     Method registers an array of nib name defined by the nibName String parameter with current table view
     - Parameter identifiers:  [String]
     */
    func registerCells(with identifiers: [String]) {
        for identifier in identifiers {
            ViewService.registerNibWithTableView(identifier, tableView: self)
        }
    }
}
