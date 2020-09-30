//
//  OrderListViewController.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 11/14/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

enum JourneyListState {
    case current
    case history
}

typealias JourneyListHistory = Results<JourneyHistory>

class JourneyListViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var manageSectionWrapperView: UIView!
    
    @IBOutlet weak var currentJourneyListWrapperView: UIView!
    @IBOutlet weak var currentJourneyTitleLb: UILabel!
    @IBOutlet weak var currentLineWrapperView: UIView!
    
    @IBOutlet weak var historyJourneyListWrapperView: UIView!
    @IBOutlet weak var historyJourneyTitleLb: UILabel!
    @IBOutlet weak var historyLineWrapperView: UIView!
    
    // MARK: - Properties
    var presenter: JourneyListPresenterProtocol?
    var currentJourneyList: Results<JourneyCurrent>! {
        get {
            return presenter?.currentJourneyList
        }
    }
    var historyJourneyList: Results<JourneyHistory>! {
        get {
            return presenter?.historyJourneyList
        }
    }
    var headerSectionView: ManageSectionJourneyListView?
    var journeyState: JourneyListState = .current {
        didSet {
            didSetJourneyListState()
        }
    }
    var journeyData: [Int: JourneyListHistory] = [:]
    var months: [Int] = []
    
    var isFirstTimeAppeared: Bool = true
    
    // MARK: - MetaData
    class func storyBoardId() -> String {
        return "JourneyListViewController"
    }
    
    class func storyBoardName() -> String {
        return "JourneyList"
    }
    
    // MARK: - View Lyfe Cycle
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
        
        isFirstTimeAppeared = false
        setupMonth()
        setupUI()
        if let presenter = presenter {
            presenter.viewDidLoad()
        }
    }
    
    func setupUI() {
        ViewService.registerNibWithTableView(JourneyListTableViewCell.getIdentifier(), tableView: tableView)
        tableView.allowsSelection = true
        tableView.rowHeight = 75
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.layer.masksToBounds = true
        let tmpHeaderView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: ViewService.screenSize().width, height: 1))
        tmpHeaderView.backgroundColor = UIColor.clear
        let tmpFooterView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: ViewService.screenSize().width, height: 1))
        tmpFooterView.backgroundColor = UIColor.clear
        tableView.tableHeaderView = tmpHeaderView
        tableView.tableFooterView = tmpFooterView
        
        tableView.addRefreshHeader { [weak self] in
            if let weakSelf = self, let presenter = weakSelf.presenter {
                presenter.getCurrentJourneyList()
                presenter.getHistoryJourneyList()
            }
        }
        
        manageSectionWrapperView.addShadow()
        currentJourneyListWrapperView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(currentJourneyListWrapperView_DidTap)))
        currentJourneyTitleLb.font = FontSystem.sectionTitle
        
        currentJourneyTitleLb.text = "HIỆN TẠI".localized
        currentJourneyTitleLb.textColor = ColorSystem.black
        currentLineWrapperView.backgroundColor = ColorSystem.green
        
        historyLineWrapperView.backgroundColor = ColorSystem.white
        historyJourneyTitleLb.text = "LỊCH SỬ".localized
        historyJourneyTitleLb.textColor = ColorSystem.blackOpacity
        historyJourneyTitleLb.font = FontSystem.sectionTitle
        historyJourneyListWrapperView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(historyJourneyListWrapperView_DidTap)))
    }
    
    // setup month
    func setupMonth() {
        for month in stride(from: 11, to: -1, by: -1) {
            months.append(month)
        }
    }
    
    func generateJourneyList() {
        if let historyList = historyJourneyList, historyList.isInvalidated == false, historyList.count > 0 {
            for i in stride(from: 11, to: -1, by: -1) { // index from 0 to 11
                var monthStr = String.init(describing: i + 1)
                if monthStr.count == 1 {
                    monthStr.insert("0", at: monthStr.startIndex)
                }
                let journeys = historyList.filter("month = %@", monthStr)
                journeyData.updateValue(journeys, forKey: i)
            }
        }
        
        
    }
    
     
    // MARK: - Methodd
    func didSetJourneyListState() {
        reloadData()
        if journeyState == .current {
            currentLineWrapperView.backgroundColor = ColorSystem.green
            historyLineWrapperView.backgroundColor = ColorSystem.white
            historyJourneyTitleLb.textColor = ColorSystem.blackOpacity
            currentJourneyTitleLb.textColor = ColorSystem.black
            currentJourneyListWrapperView.isUserInteractionEnabled = false
            historyJourneyListWrapperView.isUserInteractionEnabled = true
        }
        else {
            historyLineWrapperView.backgroundColor = ColorSystem.green
            currentLineWrapperView.backgroundColor = ColorSystem.white
            historyJourneyTitleLb.textColor = ColorSystem.black
            currentJourneyTitleLb.textColor = ColorSystem.blackOpacity
            historyJourneyListWrapperView.isUserInteractionEnabled = false
            currentJourneyListWrapperView.isUserInteractionEnabled = true
        }
    }
    
    @objc func currentJourneyListWrapperView_DidTap() {
        journeyState = .current
    }
    
    @objc func historyJourneyListWrapperView_DidTap() {
        journeyState = .history
    }
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension JourneyListViewController: UITableViewDelegate, UITableViewDataSource {
    //set section
    func numberOfSections(in tableView: UITableView) -> Int {
        if journeyState == .current {
            return 1
        }
        else {
            return months.count
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if journeyState == .current {
            if let currentList = currentJourneyList, currentList.isInvalidated == false, currentList.count > 0{
                return currentList.count
            }
            return 0
        }
        else if journeyState == .history{
            if let journeyList = journeyData[months[section]] {
                return journeyList.count
            }
            return 0
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let titleView = ViewService.viewFrom(TitleHeaderInSectionView.nibName()) as! TitleHeaderInSectionView
        titleView.frame.size.width = ViewService.screenSize().width
        titleView.setupTitle(section: String.init(describing: months[section] + 1))
        return titleView
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if journeyState == .current {
            return 0.0
        }
        else {
            if let list = journeyData[months[section]],
                list.count > 0 {
                return 30
            }
            else {
                return 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: JourneyListTableViewCell.getIdentifier(), for: indexPath) as! JourneyListTableViewCell
        if journeyState == .current {
            let journey = currentJourneyList[indexPath.row]
            if let journey = journey.journey {
                cell.setupData(journey, journeyState)
            }
        }
        else {
            if let list = journeyData[months[indexPath.section]], let journey = list[indexPath.row].journey, journey.isInvalidated == false {
                cell.setupData(journey, journeyState)
            }
            else {
                return UITableViewCell()
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if journeyState == .current {
            let journeyCurrent = currentJourneyList[indexPath.row]
            if journeyCurrent.isInvalidated == false {
                if let journey = journeyCurrent.journey, journey.isInvalidated == false {
                    // go to journeyDetail
                    if let presenter = presenter {
                        presenter.pushJourneyDetail(journey.id)
                    }
                }
            }
        }
        else {
            if let list = journeyData[months[indexPath.section]], list.isInvalidated == false {
                if let journey = list[indexPath.row].journey,
                    journey.isInvalidated == false {
                    if let presenter = presenter {
                        // go to journeyDetail
                        presenter.pushJourneyDetail(journey.id)
                    }
                }
            }
        }
    }
    
}

// MARK: - OrderListViewProtocol
extension JourneyListViewController: JourneyListViewProtocol {
    func reloadData() {
        tableView.reloadData()
        generateJourneyList()
    }
    
    func beginLoading() {
        tableView.headerBeginRefreshing()
    }
    
    func endLoading() {
        tableView.headerEndRefreshing()
    }
}
