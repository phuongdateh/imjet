//
//  ManageSectionJourneyListView.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 11/18/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import UIKit

protocol ManageSectionJourneyListViewDelegate: class {
    func manageSectionJourneyListViewDidTapCurrentList(view: ManageSectionJourneyListView)
    func manageSectionJourneyListViewDidTapHistoryList(view: ManageSectionJourneyListView)
}

class ManageSectionJourneyListView: UIView {
    
    // MARK: - NibName
    class func nibName() -> String {
        return "ManageSectionJourneyListView"
    }
    
    // MARK: - IBOutlets
    @IBOutlet weak var currentListWrapperView: UIView!
    @IBOutlet weak var currentLineWrapperView: UIView!
    @IBOutlet weak var currentTitleLb: UILabel!
    
    @IBOutlet weak var historyListWrapperView: UIView!
    @IBOutlet weak var historyLineWrapperView: UIView!
    @IBOutlet weak var historyTitleLb: UILabel!
    
    // MARK: - Properties
    weak var delegate: ManageSectionJourneyListViewDelegate?
    
    // MARK: - View LyfeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        currentTitleLb.text = "Hiện tại"
        currentTitleLb.setFontAndTextColor(fontType: .bold, size: 14, color: .black)
        
        currentLineWrapperView.backgroundColor = ColorSystem.green
        currentListWrapperView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(currentListWrapperView_DidTap)))
        
        historyTitleLb.text = "Lịch sử"
        historyTitleLb.setFontAndTextColor(fontType: .bold, size: 14, color: .gray)
        
        historyLineWrapperView.backgroundColor = .clear
        historyListWrapperView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(historyListWrapperView_DidTap)))
    }
    
    @objc func currentListWrapperView_DidTap() {
        if let delegate = delegate {
            delegate.manageSectionJourneyListViewDidTapCurrentList(view: self)
        }
    }
    
    @objc func historyListWrapperView_DidTap() {
        if let delegate = delegate {
            delegate.manageSectionJourneyListViewDidTapHistoryList(view: self)
        }
    }
    
    
    
    
    
    
    
}
