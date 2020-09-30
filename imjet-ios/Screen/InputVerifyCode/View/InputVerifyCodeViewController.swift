//
//  InputVerifyCodeViewController.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 9/14/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import UIKit
import FirebaseAuth

class InputVerifyCodeViewController: ViewController {
    
    // MARK: - IBOutlet:
    @IBOutlet weak var titleConfirmLb: UILabel!
    
    @IBOutlet weak var code1TextField: UITextField!
    @IBOutlet weak var code2TextField: UITextField!
    @IBOutlet weak var code3TextField: UITextField!
    @IBOutlet weak var code4TextField: UITextField!
    @IBOutlet weak var code5TextField: UITextField!
    @IBOutlet weak var code6TextField: UITextField!
    
    @IBOutlet weak var countDownLb: UILabel!
    @IBOutlet weak var sendCodeAgainWrapperView: UIView!
    @IBOutlet weak var sendCodeAgainTitleLb: UILabel!
    
    @IBOutlet weak var confirmWrapperView: UIView!
    @IBOutlet weak var confirmTitleLb: UILabel!
    
    
    @IBOutlet weak var backLoginWrapperView: UIView!
    @IBOutlet weak var backLoginTitleLb: UILabel!
    
    // MARK: - Protperties
    var verificationId: String?
    var time: Timer!
    var totalTime: Int = 30
    var isEndCountDown: Bool = false
    var presenter: InputVerifyCodePresenterProtocol?
    var phoneNumber: String?
    var listCodeTextField: [UITextField] = []
    
    let fullString: NSMutableAttributedString = NSMutableAttributedString.init()
    
    // MARK: - Override
    override class func storyBoardId() -> String {
        return "InputVerifyCodeViewController"
    }
    
    override class func storyBoardName() -> String {
        return "InputVerifyCode"
    }
    
    // MARK: - ViewLyfiCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        addUITapGestureRecognizer()
        
        
        if let verificationId = FirebaseAuthCustom.sharedInstance.getVerificationId() {
            self.verificationId = verificationId
        }
        
        
        startCountDown()
    }
    
    // MARK: - Method
    func setupUI() {
        
        fullString.append(NSAttributedString.init(string: "Xác nhận", attributes: [.font: FontSystem.pageTitle, .foregroundColor: ColorSystem.black]))
        fullString.append(NSAttributedString.init(string: "\nChúng tôi sẽ gửi mã xác nhận qua số điện thoại này", attributes: [.font: FontSystem.sectionTitle, .foregroundColor: ColorSystem.black]))
        titleConfirmLb.attributedText = fullString
        
       
        listCodeTextField = [code1TextField, code2TextField, code3TextField, code4TextField, code5TextField, code6TextField]
        for textField in listCodeTextField {
            textField.font = FontSystem.normalText
            textField.textColor = ColorSystem.black
            textField.addTarget(self, action: #selector(textField_DidChanged(textField:)), for: .editingChanged)
            textField.keyboardType = .numberPad
        }
        
        countDownLb.textColor = ColorSystem.black
        countDownLb.font = FontSystem.normalText

        sendCodeAgainTitleLb.textColor = ColorSystem.black
        sendCodeAgainTitleLb.font = FontSystem.buttonTitle
        sendCodeAgainTitleLb.text = "GỬI LẠI MÃ"
        sendCodeAgainWrapperView.layer.cornerRadius = 10
        sendCodeAgainWrapperView.layer.borderColor = ColorSystem.black.cgColor
        sendCodeAgainWrapperView.layer.borderWidth = 1
        
        confirmWrapperView.layer.cornerRadius = 10
        confirmWrapperView.backgroundColor = ColorSystem.black
        confirmTitleLb.textColor = ColorSystem.white
        confirmTitleLb.font = FontSystem.buttonTitle
        confirmTitleLb.text = "XÁC NHẬN"
    }
    
    func addUITapGestureRecognizer() {
        sendCodeAgainWrapperView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(sendCodeAgainWrapperView_Tap)))
        confirmWrapperView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(confirmWrapperView_Tap)))
    }
    
    // MARK: - Action
    
    @objc func textField_DidChanged(textField: UITextField) {
        if let text = textField.text {
            if text.count == 1 {
                switch textField {
                case code1TextField:
                    code2TextField.becomeFirstResponder()
                case code2TextField:
                    code3TextField.becomeFirstResponder()
                case code3TextField:
                    code4TextField.becomeFirstResponder()
                case code4TextField:
                    code5TextField.becomeFirstResponder()
                case code5TextField:
                    code6TextField.becomeFirstResponder()
                case code6TextField:
                    code6TextField.resignFirstResponder()
                default:
                    break
                }
            }
            else if text.count == 0 {
                switch textField {
                case code1TextField:
                    code1TextField.resignFirstResponder()
                case code2TextField:
                    code1TextField.becomeFirstResponder()
                case code3TextField:
                    code2TextField.becomeFirstResponder()
                case code4TextField:
                    code3TextField.becomeFirstResponder()
                case code5TextField:
                    code4TextField.becomeFirstResponder()
                case code6TextField:
                    code5TextField.becomeFirstResponder()
                default:
                    break
                }
            }
        }
    }
    
    @objc func sendCodeAgainWrapperView_Tap() {
        startCountDown()
        var phoneNumberStr: String = ""
        if let phoneNumber = phoneNumber {
            phoneNumberStr = phoneNumber
        }
        
        PhoneAuthProvider.provider().verifyPhoneNumber(phoneNumberStr, uiDelegate: nil) { (authResult, error) in
            if let error = error {
                print("Error when verify code with Firebase: \(error.localizedDescription)")
            }
            else {
                ToastView.sharedInstance.showContent("Successfull")
            }
        }
    }
    
    @objc func confirmWrapperView_Tap() {
        var verificationIdStr = ""
        if let verificationId = FirebaseAuthCustom.sharedInstance.getVerificationId() {
            verificationIdStr = verificationId
        }
        
        var codeStr: String = ""
        for textField in listCodeTextField {
            if let code = textField.text {
                codeStr.append(contentsOf: code)
            }
        }
        
        let credential = PhoneAuthProvider.provider().credential(withVerificationID: verificationIdStr, verificationCode: codeStr)
        Auth.auth().signIn(with: credential) { [weak self] (authResult, error) in
            if let error = error {
                ToastView.sharedInstance.showContent("Error With Firebase:\(error.localizedDescription)")
            }
            else {
                var phoneNumberStr = ""
                if let weakSelf = self, let phoneNumber = weakSelf.phoneNumber, let presenter = weakSelf.presenter {
                    phoneNumberStr = phoneNumber
                    UserDefaults.standard.setValue(phoneNumberStr, forKey: Constants.kPhoneNumberVerified)
                    presenter.pushRegister(phoneNumberStr)
                }
            }
        }
    }
    
    @objc func backLoginWrapperView_Tap() {
        // Navigate Login Screen
        if let navigationController = self.navigationController {
            let viewControllers = navigationController.viewControllers
            if let index = viewControllers.firstIndex(where: { (vc) -> Bool in
                if vc is LoginViewController {
                    return true
                }
                return false
            }) {
                navigationController.popToViewController(viewControllers[index], animated: true)
                return
            }
        }
        
    }
    
    func startCountDown() {
        isEndCountDown = false
        totalTime = 30
        time = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(updateTime), userInfo: nil, repeats: true)
    }
    
    @objc func updateTime() {
        countDownLb.text = "Mã xác nhận sẽ tới trong: \(timeFormatted(totalTime))"
        if totalTime != 0 {
            totalTime -= 1
        }
        else {
            endCountDown()
        }
    }
    
    func endCountDown() {
        isEndCountDown = true
        time.invalidate()
        countDownLb.text = "Bấm vào GỬI LẠI MÃ để lấy lại mã xác nhận."
    }
    
    fileprivate func timeFormatted(_ totalSeconds: Int) -> String {
        let seconds: Int = totalSeconds % 60
        let minutes: Int = (totalSeconds / 60) % 60
        //     let hours: Int = totalSeconds / 3600
        return String(format: "%02d:%02d", minutes, seconds)
    }
    
    
    
    
}

// MARK: - InputVerifyCodeViewProtocol
extension InputVerifyCodeViewController: InputVerifyCodeViewProtocol {
    
}

// MARK: - UITextFieldDelegate
extension InputVerifyCodeViewController: UITextFieldDelegate {
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        if textField.text!.count < 1 && textField.text!.count > 0 {
            return false
        }
        return true
    }
}
