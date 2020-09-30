//
//  RegisterViewController.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 9/10/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import UIKit

class RegisterViewController: ViewController {
    
    // NARK: - IBOutlet
    @IBOutlet weak var titleVCLb: UILabel!
    
    @IBOutlet weak var fullNameWrapperView: UIView!
    @IBOutlet weak var fullNameTf: UITextField!
    
    @IBOutlet weak var passwordWrapperView: UIView!
    @IBOutlet weak var passwordTf: UITextField!
    @IBOutlet weak var passwordIconImageView: UIImageView!
    @IBOutlet weak var passwordIconWrapperView: UIView!
    
    @IBOutlet weak var reTypePasswordWrapperView: UIView!
    @IBOutlet weak var reTypePasswordTf: UITextField!
    @IBOutlet weak var reTypePasswordIconImageView: UIImageView!
    @IBOutlet weak var reTypePasswordIconWrapperView: UIView!
    
    @IBOutlet weak var registerWrapperView: UIView!
    @IBOutlet weak var registerTitleLb: UILabel!
    
    // MARK: - Properties
    private var isTapped: Bool = false
    private var listWrapperView: [UIView] = []
    var presenter: RegisterPresenterProtocol?
    var phoneNumber: String?
    let attributeStr: NSMutableAttributedString = NSMutableAttributedString.init()
    
    // MARK: - Override
    override class func storyBoardId() -> String {
        return "RegisterViewController"
    }
    
    override class func storyBoardName() -> String {
        return "Register"
    }
    
    // MARK: - View Life Cycle
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let navigationController = navigationController {
            navigationController.setNavigationBarHidden(true, animated: false)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addGestureRecognizer(UITapGestureRecognizer.init(target: self.view, action: #selector(UIView.endEditing(_:))))
        registerWrapperView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(registerWrapperView_Tap)))
        
        
        setupView()
    }
    
    // MARK: - Method
    func setupView() {
        attributeStr.append(NSAttributedString.init(string: "Đăng ký\n\n".localized, attributes: [NSAttributedStringKey.font: FontSystem.pageTitle, NSAttributedStringKey.foregroundColor: ColorSystem.black]))
        attributeStr.append(NSAttributedString.init(string: "Nhập thông tin của bạn để hoàn tất đăng ký".localized, attributes: [NSAttributedStringKey.font: UIFont.init(defaultFontType: .regular, size: 14)!, NSAttributedStringKey.foregroundColor: UIColor.init(0x101010)]))
        titleVCLb.attributedText = attributeStr
        
        fullNameTf.textColor = ColorSystem.black
        fullNameTf.font = FontSystem.normalText
        fullNameTf.placeholder = "register.fullname.placeholder".localized
        
        passwordTf.textColor = ColorSystem.black
        passwordTf.font = FontSystem.normalText
        passwordTf.placeholder = "register.password.placeholder".localized
        passwordTf.isSecureTextEntry = true
        passwordIconImageView.isUserInteractionEnabled = true
        passwordIconImageView.setImage(assetId: .registerPasswordIcon)
        passwordIconWrapperView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(passwordIconImageView_Tap)))
        passwordIconWrapperView.alpha = 0
        
        reTypePasswordTf.textColor = ColorSystem.black
        reTypePasswordTf.font = FontSystem.normalText
        reTypePasswordTf.placeholder = "register.retypepassword.placeholder".localized
        reTypePasswordTf.isSecureTextEntry = true
        reTypePasswordIconImageView.isUserInteractionEnabled = true
        reTypePasswordIconImageView.setImage(assetId: .registerPasswordIcon)
        reTypePasswordIconWrapperView.alpha = 0
        reTypePasswordIconWrapperView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(reTypePasswordIconImageView_Tap)))
        
        registerTitleLb.text = "register.register.title".localized
        registerTitleLb.font = FontSystem.buttonTitle
        registerTitleLb.textColor = ColorSystem.white
        registerWrapperView.backgroundColor = ColorSystem.black
        registerWrapperView.layer.cornerRadius = 10
    }
    
    @IBAction func passwordTf_EdittingChanged(_ sender: Any) {
        if passwordTf.text!.count > 0 {
            passwordIconWrapperView.alpha = 1
        }
        else {
            passwordIconWrapperView.alpha = 0
        }
        
    }
    
    @IBAction func reTypePasswordTf_EdittingChanged(_ sender: Any) {
        if reTypePasswordTf.text!.count > 0 {
            reTypePasswordIconWrapperView.alpha = 1
        }
        else {
            reTypePasswordIconWrapperView.alpha = 0
        }
        
    }
    
    
    @objc func passwordIconImageView_Tap () {
        passwordTf.isSecureTextEntry = isTapped
        isTapped = !isTapped
        if isTapped {
            passwordIconImageView.alpha = 0.5
            
        }
        else  {
            passwordIconImageView.alpha = 1
        }
    }
    
    @objc func reTypePasswordIconImageView_Tap() {
        reTypePasswordTf.isSecureTextEntry = isTapped
        isTapped = !isTapped
        if isTapped {
            reTypePasswordIconImageView.alpha = 0.5
        }
        else  {
            reTypePasswordIconImageView.alpha = 1
        }
    }
    
    @objc func registerWrapperView_Tap() {
        var fullNameStr = ""
        var passwordStr = ""
        if let fullName = fullNameTf.text, fullName.count > 0 {
            fullNameStr = fullName
        }
        if let password = passwordTf.text, password.count > 0 {
            passwordStr = password
        }
        var phoneNumberStr: String = ""
        if let phoneNumber = phoneNumber {
            phoneNumberStr = phoneNumber
        }
        
        let userRegister = UserRegister.init(phoneNumber: phoneNumberStr, password: passwordStr, name: fullNameStr)
        switch validatePassword() {
        case 1:
            ToastView.sharedInstance.showContent("Mật khẩu phải trùng nhau và ít nhất 6 từ.")
        case -1:
            ToastView.sharedInstance.showContent("Nhập đầy đủ họ và tên.")
        case 0:
            if let presenter = presenter {
                presenter.sendRequest(userRegister)
            }
        default:
            break
        }
    }
    
    func validatePassword() -> Int {
        if (passwordTf.text != reTypePasswordTf.text) && (passwordTf.text!.count >= 6) {
            return 1 //error password
        }
        else if fullNameTf.text!.count == 0 {
            return -1 // error name
        }
        else {
            return 0 // success
        }
    }
}

// MARK: - RegisterPresenterProtocol
extension RegisterViewController: RegisterViewProtocol {
    func didSendRequestSuccess() {
//        UserDefaults.standard.removeObject(forKey: Constants.kPhoneNumberVerified)
        ToastView.sharedInstance.showContent("Đăng ký thành công.")
        AuthenticationService.lauchHomeView(nil)
    }
    
    func didSendRequestFail() {
        ToastView.sharedInstance.showContent("Không thể đăng ký.")
    }
}
