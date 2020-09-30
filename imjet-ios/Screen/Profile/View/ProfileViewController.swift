//
//  ProfileViewController.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 9/21/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import UIKit

class ProfileViewController: ViewController {
    
    // MARK: - Properties
    var profile: Profile?
    var presenter: ProfilePresenterProtocol?
    
    // MARK: - IBOutlet
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var titleNavigationBarWrapperView: UIView!
    @IBOutlet weak var titleNavigationBarLb: UILabel!
    
    @IBOutlet weak var avatarImageView: UIImageView!
    @IBOutlet weak var usernameAvatarLb: UILabel!
    
    @IBOutlet weak var avatarZoomWrapperView: UIView!
    @IBOutlet weak var avatarZoomImageView: UIImageView!
    @IBOutlet weak var avatarTitleChangeLb: UILabel!
    
    @IBOutlet weak var usernameTitleLb: UILabel!
    @IBOutlet weak var usernameLineWrapperView: UIView!
    @IBOutlet weak var usernameLb: UILabel!
    @IBOutlet weak var usernameEditImage: UIImageView!
    
    @IBOutlet weak var phonenumberTitleLb: UILabel!
    @IBOutlet weak var phonenumberLb: UILabel!
    @IBOutlet weak var phonenumberLineWrapperView: UIView!
    
    @IBOutlet weak var emailTitleLb: UILabel!
    @IBOutlet weak var emailLb: UILabel!
    @IBOutlet weak var emailLineWrapperView: UIView!
    @IBOutlet weak var emailEditImageView: UIImageView!
    
    @IBOutlet weak var confifmWrapperView: UIView!
    @IBOutlet weak var confirmTitleLb: UILabel!
    
    // MARK: - Override
    override class func storyBoardId() -> String {
        return "ProfileViewController"
    }
    
    override class func storyBoardName() -> String {
        return "Profile"
    }
    
    // MARK: - Properties
    var user: User? {
        get {
            return presenter?.user
        }
    }
    
    // MARK: - View lyficycle
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let navigationController = navigationController {
            navigationController.setNavigationBarHidden(true, animated: false)
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
//        dismiss(animated: true, completion: nil)
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
    }
    
    func setupUI() {
        titleNavigationBarWrapperView.addShadow()
        titleNavigationBarLb.text = "Thông tin của tôi"
        titleNavigationBarLb.font = FontSystem.pageTitle
        titleNavigationBarLb.textColor = ColorSystem.black
        
        avatarImageView.layer.cornerRadius = avatarImageView.frame.width/2
        avatarImageView.image = nil
        avatarImageView.backgroundColor = ColorSystem.lightGray
        usernameAvatarLb.textColor = ColorSystem.blackOpacity
        usernameAvatarLb.font = FontSystem.normalText
        
        avatarZoomImageView.layer.cornerRadius = avatarZoomImageView.frame.width/2
        avatarZoomImageView.image = nil
        avatarZoomImageView.backgroundColor = ColorSystem.lightGray
        avatarZoomWrapperView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(avatarZoomWrapperView_Tap)))
        avatarZoomWrapperView.isUserInteractionEnabled = true
        avatarTitleChangeLb.text = "Ảnh đại diện"
        avatarTitleChangeLb.textColor = ColorSystem.blackOpacity
        avatarTitleChangeLb.font = FontSystem.normalText
        
        usernameTitleLb.textColor = ColorSystem.blackOpacity
        usernameTitleLb.font = FontSystem.subSectionTitle
        usernameTitleLb.text = "HỌ TÊN"
        usernameLb.font = FontSystem.normalText
        usernameLb.textColor = ColorSystem.black
        usernameLineWrapperView.backgroundColor = ColorSystem.lightGray
        usernameEditImage.alpha = 0
        
        phonenumberTitleLb.text = "SỐ ĐIỆN THOẠI"
        phonenumberTitleLb.font = FontSystem.subSectionTitle
        phonenumberTitleLb.textColor = ColorSystem.blackOpacity
        phonenumberLb.textColor = ColorSystem.black
        phonenumberLb.font = FontSystem.normalText
        phonenumberLineWrapperView.backgroundColor = ColorSystem.lightGray
        
        emailTitleLb.text = "ĐỊA CHỈ EMAIL"
        emailTitleLb.textColor = ColorSystem.blackOpacity
        emailTitleLb.font = FontSystem.subSectionTitle
        emailLb.textColor = ColorSystem.black
        emailLb.font = FontSystem.normalText
        emailLineWrapperView.backgroundColor = ColorSystem.lightGray
        emailEditImageView.alpha = 0
        
        confifmWrapperView.backgroundColor = ColorSystem.white
        confifmWrapperView.layer.cornerRadius = 10
        confifmWrapperView.layer.borderColor = ColorSystem.black.cgColor
        confifmWrapperView.layer.borderWidth = 1
        confifmWrapperView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(confifmWrapperView_Tap)))
        confirmTitleLb.text = "ĐĂNG XUẤT"
        confirmTitleLb.textColor = ColorSystem.black
        confirmTitleLb.font = FontSystem.buttonTitle
        
        scrollView.addRefreshHeader { [weak self] in
            if let weakSelf = self, let presenter = weakSelf.presenter {
                presenter.reloadData()
            }
        }
    }
    
    @objc func avatarZoomWrapperView_Tap() {
//        ToastView.sharedInstance.showContent("Tính năng đang được phát triển")
    }
    
    func distributeData() {
        var usernameStr: String = ""
        var phonenumberStr: String = ""
        var emailStr: String = "Bổ sung sau"
        
        if let user = user, user.isInvalidated == false,
            user.isInvalidated == false {
            if let username = user.name {
                usernameStr = username
            }
            if let phonenumber = user.phoneNumber {
                phonenumberStr = phonenumber
            }
            if let email = user.email, email.count > 0 {
                emailStr = email
            }
            else {
                emailLb.textColor = ColorSystem.lightGray
            }
        }
        usernameLb.text = usernameStr
        usernameAvatarLb.text = usernameStr
        phonenumberLb.text = phonenumberStr
        emailLb.text = emailStr
    }
    
    // MARK: - Method
    @objc func confifmWrapperView_Tap() {
//        AuthenticationService.logout()
        APIServiceManager.sharedInstance.pushNotification { (_, _) in
            
        }
    }
}

// MARK: - ProfileViewProtocol
extension ProfileViewController: ProfileViewProtocol {
    func beginLoading() {
        scrollView.headerBeginRefreshing()
    }
    
    func stopLoading() {
        scrollView.headerEndRefreshing()
    }
    
    func updateView() {
        distributeData()
    }
}
