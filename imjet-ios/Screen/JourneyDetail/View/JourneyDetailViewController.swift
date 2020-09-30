//
//  JourneyDetailViewController.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 12/24/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import UIKit

class JourneyDetailViewController: UIViewController {
    
    // MARK: - IBoutlets
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var backSectionWrapperView: UIView!
    @IBOutlet weak var backButtonWrapperView: UIView!
    
    @IBOutlet weak var avatarHolderImageView: UIImageView!
    
    @IBOutlet weak var priceJourneyLb: UILabel!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var confirmWrapperView: UIView!
    @IBOutlet weak var confirmTitleLb: UILabel!
    
    @IBOutlet weak var confirmWrapperViewHeighConstraint: NSLayoutConstraint!
    
    // MARK: - Metadata
    class func storyBoardId() -> String {
        return "JourneyDetailViewController"
    }
    
    class func storyBoardName() -> String {
        return "JourneyDetail"
    }
    
    // MARK: - Properties
    var presenter: JourneyDetailPresenter?
    var tableViewData: [[String: AnyObject]] = [[:]]
    var journey: Journey? {
        return presenter?.journey
    }
    private var canbeRate: Bool = false
    
    // MARK: - Life cycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let navigationController = navigationController {
            navigationController.setNavigationBarHidden(true, animated: false)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let navigationController = navigationController {
            navigationController.setNavigationBarHidden(false, animated: false)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        if let presenter = presenter {
            presenter.viewDidLoad()
        }
        distributeData()
    }
    
    // MARK: - Method
    func setupUI() {
        backSectionWrapperView.addShadow()
        backButtonWrapperView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(backButtonWrapperView_Tap)))
        
        avatarHolderImageView.layer.cornerRadius = avatarHolderImageView.frame.size.width/2
        avatarHolderImageView.contentMode = .scaleAspectFit
        
        priceJourneyLb.font = FontSystem.sectionTitle
        
        confirmTitleLb.font = FontSystem.buttonTitle
        confirmTitleLb.textColor = ColorSystem.black
        confirmWrapperView.layer.cornerRadius = 10
        confirmWrapperView.layer.borderColor = ColorSystem.black.cgColor
        confirmWrapperView.layer.borderWidth = 0.5
        confirmWrapperView.backgroundColor = ColorSystem.white
        confirmWrapperView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(confirmWrapperView_Tap)))

        ViewService.registerNibWithTableView(JourneyDetailTableViewCell.getIdentifier(), tableView: tableView)
        scrollView.addRefreshHeader { [weak self] in
            if let weakSelf = self, let presenter = weakSelf.presenter {
                presenter.reloadData()
            }
        }
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    @objc func confirmWrapperView_Tap() {
        if let journey = journey {
            if canbeRate == false {
                if let presenter = presenter {
                    presenter.pushRating(journey)
                }
            }
            else {
                ViewService.showLoadingIndicator()
                if let presenter = presenter {
                    presenter.cancelJourney(journey.id)
                }
            }
        }
    }
    
    @objc func backButtonWrapperView_Tap() {
        self.popViewController()
    }
    
    fileprivate func distributeData() {
        if let journey = journey, journey.isInvalidated == false {
            tableViewData = [
                ["title" : "user" as AnyObject, "value": journey as AnyObject],
                ["title" : "ĐIỂM ĐÓN" as AnyObject, "value": journey.getSourceAddress() as AnyObject],
                ["title" : "ĐIỂM ĐI" as AnyObject, "value": journey.getDestinationAddress() as AnyObject],
                ["title" : "THỜI GIAN" as AnyObject, "value": journey.departureTimestamp.asDate()?.asString(format: .hourDayMonthYear) as AnyObject],
            ]
            if let userPurpose = journey.userPurpose {
                guard let totalFeeStr = (journey.totalFee as NSNumber).asCurrencyString() else { return }
                if userPurpose == PurposeType.helmetUser.rawValue || userPurpose == PurposeType.nonHelmetUser.rawValue  {
                    avatarHolderImageView.setImage(assetId: .iconUserHome)
                    priceJourneyLb.textColor = ColorSystem.red
                    priceJourneyLb.text = "- \(totalFeeStr) "
                }
                else {
                    avatarHolderImageView.setImage(assetId: .iconDriverHome)
                    priceJourneyLb.textColor = ColorSystem.green
                    priceJourneyLb.text = "+ \(totalFeeStr)"
                }
            }
            
            if let status = journey.status {
                if status == SearchJourneyStatus.assigning.rawValue || status == SearchJourneyStatus.searching.rawValue {
                    let timestamp = Date().timeIntervalSince1970
                    if Int(timestamp) <= journey.arrivalTimestamp {
                        canbeRate = true
                        confirmTitleLb.text = "HUỶ CHUYẾN"
                    }
                    else {
                        canbeRate = false
                        confirmTitleLb.text = "ĐÁNH GIÁ"
                    }
                }
                else if status == SearchJourneyStatus.cancelled.rawValue {
                    confirmTitleLb.text = "ĐÃ HUỶ"
                    confirmTitleLb.textColor = ColorSystem.blackOpacity
                    confirmWrapperView.isUserInteractionEnabled = false
                    confirmWrapperView.layer.borderColor = ColorSystem.blackOpacity.cgColor
                }
            }
        }
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension JourneyDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableViewData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: JourneyDetailTableViewCell.getIdentifier(), for: indexPath) as! JourneyDetailTableViewCell
        cell.info = tableViewData[indexPath.row]
        return cell
    }
}

// MARK: - JourneyDetailViewProtocol
extension JourneyDetailViewController: JourneyDetailViewProtocol {
    func beginLoading() {
        scrollView.headerBeginRefreshing()
    }
    
    func stopLoading() {
        scrollView.headerEndRefreshing()
    }
    
    func updateView() {
        distributeData()
        tableView.reloadData()
    }
    
    func didCancelJourneySuccess() {
        ViewService.hideLoadingIndicator()
        self.popViewController()
    }
    
    func didCancelJourneyFail() {
        ViewService.hideLoadingIndicator()
        ToastView.sharedInstance.showContent("Bạn không thể huỷ chuyến hiện tại.")
    }
}
