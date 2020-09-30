//
//  SlideMenu.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 8/26/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import UIKit

class SlideMenuViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var menuWrapperView: UIView!
    @IBOutlet weak var cancelWrapperView: UIView!
    @IBOutlet weak var wrapperViewTrailingConstraint: NSLayoutConstraint!
    @IBOutlet weak var wrapperViewWithConstraint: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    
    
    // MARK: - Propeties
    let widthMenu: CGFloat = ViewService.screenSize().width*4/5
    var presenter: SlideMenuPresenterProtocol?
    var infoList: [[String: AnyObject]] = [[:]]
    
    // MARK: - Override
     class func storyBoardId() -> String {
        return "SlideMenuViewController"
    }
    
     class func storyBoardName() -> String {
        return "SlideMenu"
    }
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        cancelWrapperView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(wrapperView_DidTap)))
        setNeedsStatusBarAppearanceUpdate()
        
        ViewService.registerNibWithTableView(MenuTableViewCell.getIdentifier(), tableView: tableView)
        tableView.delegate = self
        tableView.dataSource = self
        
        setupInfoList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let navigationController = navigationController {
            navigationController.setNavigationBarHidden(true, animated: false)
        }
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        wrapperViewWithConstraint.constant = widthMenu
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseIn, animations: { [weak self] in
            if let weakSelf = self {
//                weakSelf.wrapperViewWithConstraint.constant += weakSelf.widthMenu
                weakSelf.view.layoutIfNeeded()
            }
        })
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let navigationController = navigationController {
            navigationController.setNavigationBarHidden(false, animated: false)
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    // MARK: - Method
    @objc func wrapperView_DidTap() {
        UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseIn, animations: {[weak self] in
            if let weakSelf = self {
                weakSelf.wrapperViewWithConstraint.constant -= weakSelf.widthMenu
                weakSelf.view.layoutIfNeeded()
            }
        }) {[weak self] (isCompleted) in
            if let weakSelf = self, isCompleted == true {
                weakSelf.dismiss(animated: false, completion: nil)
            }

        }
    }
    
    func setupInfoList() {
        infoList = [
            ["id": "profile" as AnyObject, "name": "Thông tin cá nhân" as AnyObject],
            ["id": "thongke" as AnyObject, "name": "Thống kê" as AnyObject],
            ["id": "logout" as AnyObject, "name": " Đằng Xuất" as AnyObject]
        ]
    }
}

// MARL: - SlideMenuViewProtocol
extension SlideMenuViewController: SlideMenuViewProtocol {
    
}

// MARK: - UITableViewDelegate, UITableViewDataSource
extension SlideMenuViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return infoList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: MenuTableViewCell.getIdentifier(), for: indexPath) as! MenuTableViewCell
        cell.selectionStyle = .none
        cell.info = infoList[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let info = infoList[indexPath.row]
        if let id = info["id"] as? String {
            if id == "profile" {
                if let presenter = presenter {
                    presenter.pushProfile()
                }
                
            }
            else if id == "thongke" {
                print("thongke")
            }
            else if id == "logout" {
                AuthenticationService.logout()
            }
        }
    }
}
