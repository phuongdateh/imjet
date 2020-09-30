//
//  SearchingTableViewCell.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 12/13/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import UIKit
import Shimmer

class SearchingTableViewCell: UITableViewCell {
    
    private var shimmerView: FBShimmeringView!
    
    // MARK: - Identifier
    class func getIdentifier() -> String {
        return "SearchingTableViewCell"
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        shimmerView = FBShimmeringView.init(frame: CGRect.init(x: 0, y: 0, width: ViewService.screenSize().width, height: 57))
        addSubview(shimmerView)
        let constraints: [NSLayoutConstraint] = [
            NSLayoutConstraint.init(item: shimmerView, attribute: .top, relatedBy: .equal, toItem: self, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint.init(item: shimmerView, attribute: .bottom, relatedBy: .equal, toItem: self, attribute: .bottom, multiplier: 1, constant: 0),
            NSLayoutConstraint.init(item: shimmerView, attribute: .leading, relatedBy: .equal, toItem: self, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint.init(item: shimmerView, attribute: .trailing, relatedBy: .equal, toItem: self, attribute: .trailing, multiplier: 1, constant: 0)
        ]
        addConstraints(constraints)
        shimmerView.backgroundColor = .clear
        shimmerView.contentView = contentView
        
        shimmerView.isShimmering = true
    }
    
    
    
    class func getHeight() -> CGFloat {
        return 50.5
    }
}
