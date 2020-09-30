//
//  LoginViewController.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 8/27/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import UIKit
import FBSDKLoginKit
import GoogleSignIn

class LoginViewController: ViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var labelLoginLb: UILabel!
    
    @IBOutlet weak var phoneNumberWrapperView: UIView!
    @IBOutlet weak var phoneNumberTf: UITextField!
    @IBOutlet weak var phoneNumberIconImageView: UIImageView!
    @IBOutlet weak var passwordWrapperView: UIView!
    @IBOutlet weak var passwordTf: UITextField!
    @IBOutlet weak var passwordIconImageView: UIImageView!
    @IBOutlet weak var loginWrapperView: UIView!
    @IBOutlet weak var loginLb: UILabel!
    @IBOutlet weak var registerWrapperView: UIView!
    @IBOutlet weak var registerLb: UILabel!
    @IBOutlet weak var forgotPasswrodLb: UILabel!
    @IBOutlet weak var loginWithFacebookWrapperView: UIView!
    @IBOutlet weak var loginwithFacebookIconImageView: UIImageView!
    @IBOutlet weak var loginWithGmailWrapperView: UIView!
    @IBOutlet weak var loginWithGmailIconImageView: UIImageView!
    
    @IBOutlet weak var errorPhoneNumberLb: UILabel!
    @IBOutlet weak var errorPasswordLb: UILabel!
    @IBOutlet weak var anortherLoginLb: UILabel!
    
    @IBOutlet weak var phoneNumberLineWrapperView: UIView!
    @IBOutlet weak var passwordLineWrapperView: UIView!
    
    // MARK: - Properties
    var launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    var presenter: LoginPresenterProtocol?
    var loginAtributeStr = NSMutableAttributedString()
    
    // MARK: - Metadata
    override class func storyBoardId() -> String {
        return "LoginViewController"
    }
    
    override class func storyBoardName() -> String {
        return "Login"
    }
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        GIDSignIn.sharedInstance().presentingViewController = self
        GIDSignIn.sharedInstance().delegate = self

        
        
        loginWrapperView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(loginWrapperView_Tap)))
        loginWithFacebookWrapperView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(loginWithFacebookWrapperView_Tap)))
        loginWithGmailWrapperView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(loginWithGmailWrapperView_Tap)))
        registerWrapperView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(registerWrapperView_Tap)))
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let navigationController = navigationController {
            navigationController.isNavigationBarHidden = true
        }
        removeText()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if let navigationController = navigationController {
            navigationController.isNavigationBarHidden = false
        }
    }
    
    // MARK: - UITapGesture
    @objc func loginWrapperView_Tap() {
       
        var phoneNumberStr = ""
        if let phoneNumber = phoneNumberTf.text, phoneNumber.count > 0 {
            phoneNumberStr = phoneNumber
        }
        var passwordStr = ""
        if let password = passwordTf.text, password.count > 0 {
            passwordStr = password
        }
        let userLogin = UserLogin.init(phoneNumber: phoneNumberStr, password: passwordStr)
        
        if phoneNumberTf.text != nil && phoneNumberTf.text!.count > 0 {
            if passwordTf.text != nil && passwordTf.text!.count > 0 {
                if let presenter = presenter {
                    ViewService.showLoadingIndicator()
                    presenter.loginByPhone(userLogin)
                }
            }
            else if passwordTf.text == nil || passwordTf.text!.count == 0 {
                errorPasswordLb.text = "Mật khẩu không được bỏ trống."
            }
        }
        else if phoneNumberTf.text == nil || phoneNumberTf.text!.count == 0 {
            errorPhoneNumberLb.text = "Số điện thoại không được bỏ trống."
        }
        else if phoneNumberStr.count > 12 || phoneNumberStr.count < 9 {
            errorPhoneNumberLb.text = "Số điện thoại không hợp lệ."
        }
        validatePhoneAndPassword()
    }
    
    // MARK: - Login Social
    @objc func loginWithFacebookWrapperView_Tap() {
        let loginManager = LoginManager()
        
        loginManager.logIn(permissions: ["email"], from: self) { [weak self](result, error) in
            if let error = error {
                print("error: \(error.localizedDescription)")
                LoginManager().logOut()
            }
            else if let result = result, result.isCancelled {
                print("LoginFB Faild")
                LoginManager().logOut()
            }
            else {
                if let tokenString = AccessToken.current?.tokenString {
                    if let weakSelf = self, let presenter = weakSelf.presenter {
                        presenter.loginByFacebook(token: tokenString)
                    }
                }
            }
        }
    }
    
    @objc func loginWithGmailWrapperView_Tap() {
        GIDSignIn.sharedInstance().signIn()
    }
    
    @objc func registerWrapperView_Tap() {
        if let presenter = presenter {
            presenter.pushInputPhoneNUmber()
        }
    }
    
    func validatePhoneAndPassword() {
        if errorPhoneNumberLb.text!.count > 0 {
            phoneNumberLineWrapperView.backgroundColor = ColorSystem.red
        }
        else {
            phoneNumberLineWrapperView.backgroundColor = UIColor.init(0xE3E3E3)
        }
        
        if errorPasswordLb.text!.count > 0 {
            passwordLineWrapperView.backgroundColor = ColorSystem.red
        }
        else {
            passwordLineWrapperView.backgroundColor = UIColor.init(0xE3E3E3)
        }
        
        
    }
    
    // MARK: - IBAction
    @IBAction func phoneNumber_EditingChanged(_ sender: Any) {
        validatePhoneAndPassword()
        
    }
    
    @IBAction func password_EditingChanged(_ sender: Any) {
        validatePhoneAndPassword()
        
    }
    

    // MARK: - Navigate Screen
    fileprivate func navigateProvicePurpose() {
        AuthenticationService.lauchHomeView(nil)
    }
    
    // MARK: - Method
    fileprivate func setupUI() {
        forgotPasswrodLb.text = "" // pendding forgot password
        
        loginAtributeStr.append(NSAttributedString.init(string: "login.title.page.signin".localized, attributes: [NSAttributedString.Key.font: FontSystem.pageTitle,NSAttributedStringKey.foregroundColor: ColorSystem.black]))
        loginAtributeStr.append(NSAttributedString.init(string: "\n\n" + "login.title.content".localized, attributes: [NSAttributedStringKey.font: FontSystem.normalText, NSAttributedStringKey.foregroundColor: ColorSystem.black]))
        labelLoginLb.attributedText = loginAtributeStr
        
        errorPhoneNumberLb.text = ""
        errorPhoneNumberLb.font = UIFont.init(defaultFontType: .medium, size: 10)
        errorPasswordLb.text = ""
        errorPasswordLb.font =  UIFont.init(defaultFontType: .medium, size: 10)
        
        loginLb.font = FontSystem.buttonTitle
        loginLb.text = "login.title.signin".localized
        loginLb.textColor = ColorSystem.white
        loginWrapperView.backgroundColor = ColorSystem.black
        loginWrapperView.layer.cornerRadius = 10
        
        registerLb.font = FontSystem.buttonTitle
        registerLb.text = "login.title.signup".localized
        registerLb.textColor = ColorSystem.black
        registerWrapperView.backgroundColor = ColorSystem.white
        registerWrapperView.layer.borderColor = ColorSystem.black.cgColor
        registerWrapperView.layer.borderWidth = 1
        registerWrapperView.layer.cornerRadius = 10
        
        anortherLoginLb.setFontAndTextColor(fontType: .regular, size: 14, color: .black)
        anortherLoginLb.text = "login.anorther.title".localized
        
        phoneNumberTf.keyboardType = .numberPad
        phoneNumberTf.font = FontSystem.normalText
        phoneNumberTf.textColor = ColorSystem.black
        phoneNumberTf.placeholder = "login.phonenumber.placeholder".localized
        phoneNumberIconImageView.setImage(assetId: .phone_number_icon)
        phoneNumberIconImageView.alpha = 0.6
        
        
       
        passwordIconImageView.setImage(assetId: .password_icon)
        passwordIconImageView.alpha = 0.6
        passwordTf.isSecureTextEntry = true
        passwordTf.placeholder = "login.password.placeholder".localized
    }
    
    fileprivate func removeText() {
        phoneNumberTf.text = ""
        errorPhoneNumberLb.text = ""
        passwordTf.text = ""
        errorPasswordLb.text = ""
        
        phoneNumberLineWrapperView.backgroundColor = UIColor.init(0xE3E3E3)
        passwordLineWrapperView.backgroundColor = UIColor.init(0xE3E3E3)
    }
    
}

// MARK: - Extension LoginViewProtocol
extension LoginViewController: LoginViewProtocol {
    func didLoginByPhoneSuccess() {
        ViewService.hideLoadingIndicator()
        navigateProvicePurpose()
    }
    
    func didLoginByPhoneFail(_ errorCode: Int) {
        ViewService.hideLoadingIndicator()
        if errorCode == 7 {
            errorPasswordLb.text = "login.error.password.notmatch".localized
            passwordLineWrapperView.backgroundColor = ColorSystem.red
        }
        else {
            errorPasswordLb.text = "Đã xảy ra lỗi."
        }
    }
    
    func didLoginByFacebookSuccess() {
        LoginManager().logOut()
    }
    
    func didLoginByFacebookFail() {
        LoginManager().logOut()
        ToastView.sharedInstance.showContent("Login FB Fail")
    }
    
    func didLoginByGoogleSuccess() {
        GIDSignIn.sharedInstance().signOut()
        navigateProvicePurpose()
    }
    
    func didLoginByGoogleFail() {
        GIDSignIn.sharedInstance().signOut()
        ToastView.sharedInstance.showContent("Login Gmail Fail")
    }
}

// MARK: - GIDSignInDelegagte
extension LoginViewController: GIDSignInDelegate {
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!, withError error: Error!) {
        if let error = error {
            print("error: \(error.localizedDescription)")
            ToastView.sharedInstance.showContent("\(error.localizedDescription)")
        }
        else if let user = user, let authentication = user.authentication, let idToken = authentication.idToken {
            if let presenter = presenter {
                presenter.loginByGoogle(token: idToken)
            }
        }
    }
}


