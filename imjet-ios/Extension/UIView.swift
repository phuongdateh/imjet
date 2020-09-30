//
//  UIView.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 9/17/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import UIKit
import Shimmer

enum UIViewShadowVerticalDirection {
    case top
    case bottom
}

extension UIView {
    
    func addShimering(speed: CGFloat = 150) -> FBShimmeringView {
        let shimmeringView = FBShimmeringView()
        shimmeringView.frame = self.frame
        shimmeringView.isShimmering = false
        shimmeringView.shimmeringBeginFadeDuration = 0.5
        shimmeringView.shimmeringSpeed = speed
        shimmeringView.shimmeringOpacity = 1
        shimmeringView.contentView = self
        return shimmeringView
    }
    
    func dropShadow(scale: Bool = true) {
      layer.masksToBounds = false
      layer.shadowColor = UIColor.black.cgColor
      layer.shadowOpacity = 0.5
      layer.shadowOffset = CGSize(width: -1, height: 1)
      layer.shadowRadius = 1

      layer.shadowPath = UIBezierPath(rect: bounds).cgPath
      layer.shouldRasterize = true
      layer.rasterizationScale = scale ? UIScreen.main.scale : 1
    }

    func addShadow1() {
        layer.shadowColor = UIColor.red.cgColor
        layer.shadowOpacity = 1
        layer.masksToBounds = false
        layer.shadowOffset = CGSize.init(width: 6, height:6)
        layer.shadowRadius = 10
    }
    
    func addShadow() {
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOpacity = 1
        layer.masksToBounds = false
        layer.shadowOffset = CGSize.init(width: 6, height:6)
        layer.shadowRadius = 2.5
    }
    
    func addShadowToOneSide(verticalDirection: UIViewShadowVerticalDirection) {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.darkGray.cgColor
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 5
        
        switch verticalDirection {
        case .bottom:
            layer.shadowOffset = CGSize.init(width: 0, height: 2)
            
        case .top:
            layer.shadowOffset = CGSize.init(width: 0, height: -2)
        }
    }
    
    func addChildView(_ childView: UIView,
                      top: CGFloat = 0,
                      bottom: CGFloat = 0,
                      trailing: CGFloat = 0,
                      leading: CGFloat = 0) {
        addSubview(childView)
        childView.translatesAutoresizingMaskIntoConstraints = false
        let constraints: [NSLayoutConstraint] = [childView.alignTop(to: self, space: top),
                                                 childView.alignBottom(to: self, space: bottom),
                                                 childView.alignLeading(to: self, space: leading),
                                                 childView.alignTrailing(to: self, space: trailing)]
        addConstraints(constraints)
    }
    
    func addCornerRadiusAndBorderWidth(cornerRadius: CGFloat, borderColor: UIColor, borderWidth: CGFloat, masksToBounds: Bool = false) {
        layer.masksToBounds = masksToBounds
        layer.cornerRadius = cornerRadius
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = borderWidth
    }
}

extension UIView {
    
    // align trailling to destinationView
    func alignTrailing(to destinationView: UIView,
                       relation: NSLayoutConstraint.Relation = .equal,
                       multiplier: CGFloat = 1,
                       space: CGFloat = 0,
                       priority: Float = 1000) -> NSLayoutConstraint {
        
        let constraint = NSLayoutConstraint.init(item: self,
                                                 attribute: .trailing,
                                                 relatedBy: relation,
                                                 toItem: destinationView,
                                                 attribute: .trailing,
                                                 multiplier: multiplier,
                                                 constant: -space)
        constraint.priority = UILayoutPriority.init(priority)
        return constraint
    }
    
    // align leading to destinationView
    func alignLeading(to destinationView: UIView,
                      relation: NSLayoutConstraint.Relation = .equal,
                      multiplier: CGFloat = 1,
                      space: CGFloat = 0,
                      priority: Float = 1000) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint.init(item: self,
                                                 attribute: .leading,
                                                 relatedBy: relation,
                                                 toItem: destinationView,
                                                 attribute: .leading,
                                                 multiplier: multiplier,
                                                 constant: space)
        constraint.priority = UILayoutPriority.init(priority)
        return constraint
    }
    
    // align top to destinationView
    func alignTop(to destinationView: UIView,
                  relation: NSLayoutConstraint.Relation = .equal,
                  multiplier: CGFloat = 1,
                  space: CGFloat = 0,
                  priority: Float = 1000) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint.init(item: self,
                                                 attribute: .top,
                                                 relatedBy: relation,
                                                 toItem: destinationView,
                                                 attribute: .top,
                                                 multiplier: multiplier,
                                                 constant: space)
        constraint.priority = UILayoutPriority.init(priority)
        return constraint
    }
    
    // align bottom to destinationView
    func alignBottom(to destinationView: UIView,
                     relation: NSLayoutConstraint.Relation = .equal,
                     multiplier: CGFloat = 1,
                     space: CGFloat = 0,
                     priority: Float = 1000) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint.init(item: self,
                                                 attribute: .bottom,
                                                 relatedBy: relation,
                                                 toItem: destinationView,
                                                 attribute: .bottom,
                                                 multiplier: multiplier,
                                                 constant: -space)
        constraint.priority = UILayoutPriority.init(priority)
        return constraint
    }
    
     /// spacing view's trailing side to destinationView's leading side
    func spacingRight(to destinationView: UIView,
                      relation: NSLayoutConstraint.Relation = .equal,
                      multiplier: CGFloat = 1,
                      space: CGFloat = 0,
                      priority: Float = 1000) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint.init(item: destinationView, attribute: .leading, relatedBy: relation, toItem: self, attribute: .trailing, multiplier: multiplier, constant: space)
        constraint.priority = UILayoutPriority.init(priority)
        return constraint
    }
    
    /// spacing view's leading side to destinationView's trailing side
    func spacingLeft(to destinationView: UIView,
                     relation: NSLayoutConstraint.Relation = .equal,
                     multiplier: CGFloat = 1,
                     space: CGFloat = 0,
                     priority: Float = 0) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint.init(item: self, attribute: .leading, relatedBy: relation, toItem: destinationView, attribute: .trailing, multiplier: multiplier, constant: space)
        constraint.priority = UILayoutPriority.init(priority)
        return constraint
    }
    
    /// spacing view's bottom side to destinationView's top side
    func spacingBottom(to destinationView: UIView,
                      relation: NSLayoutConstraint.Relation = .equal,
                      multiplier: CGFloat = 1,
                      space: CGFloat = 0,
                      priority: Float = 1000) -> NSLayoutConstraint {
        
        let constraint: NSLayoutConstraint = NSLayoutConstraint.init(item: destinationView,
                                                                     attribute: .top,
                                                                     relatedBy: relation,
                                                                     toItem: self,
                                                                     attribute: .bottom,
                                                                     multiplier: 1,
                                                                     constant: -space)
        constraint.priority = UILayoutPriority.init(priority)
        return constraint
    }
    
    /// spacing view's top side to destinationView's bottom side
    func spacingTop(to destinationView: UIView,
                      relation: NSLayoutConstraint.Relation = .equal,
                      multiplier: CGFloat = 1,
                      space: CGFloat = 0,
                      priority: Float = 1000) -> NSLayoutConstraint {
        
        let constraint: NSLayoutConstraint = NSLayoutConstraint.init(item: self,
                                                                     attribute: .top,
                                                                     relatedBy: relation,
                                                                     toItem: destinationView,
                                                                     attribute: .bottom,
                                                                     multiplier: 1,
                                                                     constant: space)
        constraint.priority = UILayoutPriority.init(priority)
        return constraint
    }
    
    // config height constraint
    func configHeight(relation: NSLayoutConstraint.Relation = .equal,
                      multipler: CGFloat = 1,
                      _ height: CGFloat,
                      priority: Float = 1000) -> NSLayoutConstraint {
        let constraint: NSLayoutConstraint = NSLayoutConstraint.init(item: self, attribute: .height, relatedBy: relation, toItem: nil, attribute: .notAnAttribute, multiplier: multipler, constant: height)
        constraint.priority = UILayoutPriority.init(priority)
        return constraint
    }
    
    // config width constraint
    func configWidth(relation: NSLayoutConstraint.Relation = .equal,
                      multipler: CGFloat = 1,
                      _ width: CGFloat,
                      priority: Float = 1000) -> NSLayoutConstraint {
        let constraint: NSLayoutConstraint = NSLayoutConstraint.init(item: self, attribute: .width, relatedBy: relation, toItem: nil, attribute: .notAnAttribute, multiplier: multipler, constant: width)
        constraint.priority = UILayoutPriority.init(priority)
        return constraint
    }
    
    // relation width to destination view
    func relationWidth(to destinationView: UIView,
                       relation: NSLayoutConstraint.Relation = .equal,
                       multiplier: CGFloat = 1,
                       constant: CGFloat = 0,
                       priority: Float = 1000) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint.init(item: self, attribute: .width, relatedBy: relation, toItem: destinationView, attribute: .width, multiplier: 1, constant: 0)
        constraint.priority = UILayoutPriority.init(priority)
        return constraint
    }
    
    
    // relation height to destination view
    func relationHeight(to destinationView: UIView,
                       relation: NSLayoutConstraint.Relation = .equal,
                       multiplier: CGFloat = 1,
                       constant: CGFloat = 0,
                       priority: Float = 1000) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint.init(item: self, attribute: .height, relatedBy: relation, toItem: destinationView, attribute: .height, multiplier: 1, constant: 0)
        constraint.priority = UILayoutPriority.init(priority)
        return constraint
    }
    
    // relation center x to destination view
    func relationCenterX(to destinationView: UIView,
                        relation: NSLayoutConstraint.Relation = .equal,
                        multiplier: CGFloat = 1,
                        constant: CGFloat = 0,
                        priority: Float = 1000) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint.init(item: self, attribute: .centerX, relatedBy: relation, toItem: destinationView, attribute: .centerX, multiplier: 1, constant: 0)
        constraint.priority = UILayoutPriority.init(priority)
        return constraint
    }
    
    // relation center y to destination view
    func relationCenterY(to destinationView: UIView,
                         relation: NSLayoutConstraint.Relation = .equal,
                         multiplier: CGFloat = 1,
                         constant: CGFloat = 0,
                         priority: Float = 1000) -> NSLayoutConstraint {
        let constraint = NSLayoutConstraint.init(item: self, attribute: .centerY, relatedBy: relation, toItem: destinationView, attribute: .centerY, multiplier: 1, constant: 0)
        constraint.priority = UILayoutPriority.init(priority)
        return constraint
    }
    
    func addSubviewForLayout(_ view: UIView) {
        addSubview(view)
        view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    
    
}
