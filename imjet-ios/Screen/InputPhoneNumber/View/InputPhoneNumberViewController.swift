//
//  InputPhoneNumberViewController.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 9/12/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import UIKit
import FirebaseUI

class InputPhoneNumberViewController: ViewController {
    
    // MARK: - Propesties
    private var locate: Locale?
//    private let apiKey: String = "6LchBLgUAAAAAHPCZlcRF8o-djT4WrOZm5Ssy0NZ"
    private let apiKey: String = "AIzaSyCSMkLQbefFBwrbNO0rfVAaF1lAVRFp9HU"
    private let urlString: String = "http://imjet-1567520812918.firebaseio.com"
    var presenter: InputPhoneNumberPresenterProtocol?
    var phoneNumberStr: String = ""
    var verificationIdString: String = ""
    private var isValidateSuccess: Bool = false
    
    // MARK: - IBOutlet
    @IBOutlet weak var registerLb: UILabel!
    @IBOutlet weak var phoneNumberWrapperView: UIView!
    @IBOutlet weak var lineWrapperView: UIView!
    @IBOutlet weak var phoneNumberTf: UITextField!
    @IBOutlet weak var confirmWrapperView: UIView!
    @IBOutlet weak var confirmLb: UILabel!
    @IBOutlet weak var backLoginWrapperView: UIView!
    @IBOutlet weak var backLoginLb: UILabel!
    @IBOutlet weak var errorPhoneNumberLb: UILabel!
    
    // MARK: - Override
    override class func storyBoardId() -> String {
        return "InputPhoneNumberViewController"
    }
    
    override class func storyBoardName() -> String {
        return "InputPhoneNumber"
    }
    
    // MARK: - Properties
    let fullString: NSMutableAttributedString = NSMutableAttributedString.init()
    
    // MARK: - View Lyfecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationTitle("Đăng ký")
        
        fullString.append(NSAttributedString.init(string: "Đăng ký", attributes: [.font: FontSystem.pageTitle, .foregroundColor: ColorSystem.black]))
        fullString.append(NSAttributedString.init(string: "\n\nNhập số điện thoại để qua bước tiếp.", attributes: [.font: FontSystem.normalText, .foregroundColor: ColorSystem.black]))
        registerLb.attributedText = fullString
        
        phoneNumberTf.keyboardType = .numberPad
        phoneNumberTf.font = FontSystem.normalText
        phoneNumberTf.textColor = ColorSystem.black
        phoneNumberTf.placeholder = "Số điện thoại( Vd: 0909-999-987)"
        
        lineWrapperView.backgroundColor = ColorSystem.blackOpacity
        
        errorPhoneNumberLb.font = UIFont.init(defaultFontType: .regular, size: 10)
        errorPhoneNumberLb.text = ""
        
        confirmLb.text = "TIẾP THEO"
        confirmLb.textColor = ColorSystem.white
        confirmLb.font = FontSystem.buttonTitle
        confirmWrapperView.layer.cornerRadius = 10
        confirmWrapperView.backgroundColor = ColorSystem.black
        confirmWrapperView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(confirmWrapperView_Tap)))
        
        backLoginLb.text = "ĐĂNG NHẬP SĐT KHÁC"
        backLoginLb.textColor = ColorSystem.black
        backLoginLb.font = FontSystem.buttonTitle
        backLoginWrapperView.backgroundColor = ColorSystem.white
        backLoginWrapperView.addCornerRadiusAndBorderWidth(cornerRadius: 10, borderColor: ColorSystem.black, borderWidth: 1)
        backLoginWrapperView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(backLoginWrapperView_Tap)))
        
//        hiddenConfirmWrapperView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        phoneNumberTf.becomeFirstResponder()
    }
    
    // MARK: - UITapgesture
    @objc func confirmWrapperView_Tap() {
        var phoneNumberStr = ""
        if let phoneNumber = phoneNumberTf.text, phoneNumber.count > 0 {
            phoneNumberStr = phoneNumber
        }
        let phoneNumber = VerifyPhone.init(phoneNumber: phoneNumberStr)
        
        if phoneNumberTf.text == nil || phoneNumberTf.text!.count == 0 {
            errorPhoneNumberLb.text = "Số điện thoại không được để trống."
        }
        else if phoneNumberTf.text!.count < 9 || phoneNumberTf.text!.count > 12 {
            errorPhoneNumberLb.text = "Số điện thoại không hợp lệ."
        }
        else if phoneNumberTf.text != nil && phoneNumberTf.text!.count > 0 {
            if let presenter = presenter {
                presenter.verifyPhone(phone: phoneNumber)
            }
        }
        
        validatePhoneNumber()
        
//        if phoneNumberTf.text!.validate(with: .number) == false {
//            ToastView.sharedInstance.showContent("PhoneNumber Invalid")
//        }
//        else {
//            if let presenter = presenter {
//                presenter.verifyPhone(phone: phoneNumber)
//            }
//        }
    }
    
    @objc func backLoginWrapperView_Tap() {
        if let navigationController = navigationController {
            let viewControllers = navigationController.viewControllers
            if let index = viewControllers.firstIndex(of: self), index > 0 {
                navigationController.popViewController(animated: true)
            }
        }
    }
    
    
    @IBAction func phoneNumberTf_EditingChanged(_ sender: Any) {
        validatePhoneNumber()
        view.setNeedsLayout()
        view.layoutIfNeeded()
    }
    
    // MARK: - Method
    private func hiddenConfirmWrapperView() {
        confirmWrapperView.backgroundColor = ColorSystem.lightGray
        confirmWrapperView.layer.borderColor = ColorSystem.lightGray.cgColor
        confirmWrapperView.isUserInteractionEnabled = false
    }
    
    private func showConfirmWrapperView() {
        confirmWrapperView.isUserInteractionEnabled = true
        confirmWrapperView.backgroundColor = ColorSystem.black
    }
    
    func validatePhoneNumber() {
        isValidateSuccess = false
        if phoneNumberTf.text == nil || phoneNumberTf.text!.count == 0 {
            errorPhoneNumberLb.text = "Số điện thoại không được bỏ trống."
            
        } else if phoneNumberTf.text!.validate(with: .number) == false {
            errorPhoneNumberLb.text = "Số điện thoại không hợp lệ."
        }
        else if phoneNumberTf.text!.isCorrectPhoneNumberFormat() == false{
            errorPhoneNumberLb.text = "Số điện thoại không đúng định đạng."
        }
        else {
            isValidateSuccess = true
            errorPhoneNumberLb.text = ""
        }
        
        if isValidateSuccess == true {
            confirmWrapperView.backgroundColor = ColorSystem.black
            confirmWrapperView.isUserInteractionEnabled = true
            
        }
        else {
            confirmWrapperView.backgroundColor = ColorSystem.lightGray
            confirmWrapperView.isUserInteractionEnabled = false
            
        }
        
        if errorPhoneNumberLb.text!.count > 0 {
            lineWrapperView.backgroundColor = ColorSystem.red
        }
        else {
            lineWrapperView.backgroundColor = ColorSystem.blackOpacity
        }
    }
    
    
    
}

// MARK: InputPhoneNumberViewProtocol
extension InputPhoneNumberViewController: InputPhoneNumberViewProtocol {
    func didSendVerifyPhoneSuccess(code: Int) {
        ToastView.sharedInstance.showContent(CodeEnum.create(code))
        if code == 13 {
            verifyPhoneNumberAgain()
        }
        else if code == 14 {
            // Phone_Number_Verified
            var phoneNumberStr: String = ""
            if let phoneNumber = phoneNumberTf.text {
                phoneNumberStr = phoneNumber
                if let presenter = presenter {
                    presenter.pushRegister(phoneNumberStr)
                }
            }
        }
        else if code == 10 {
            errorPhoneNumberLb.text = "Số điện thoại đã tồn tại."
        }
    }
    
    func didSendVerifyPhoneFail(code: Int) {
        ToastView.sharedInstance.showContent("Không xác nhận được SĐT")
//        verifyPhoneNumberAgain()
    }
    
    fileprivate func verifyPhoneNumberAgain() {
        if let phoneNumber = phoneNumberTf.text, phoneNumber.count > 0 {
            phoneNumberStr = phoneNumber
            if phoneNumberStr.getSubString(offsetBy: 2) == "84" {
                FirebaseAuthCustom.sharedInstance.verifyPhoneNumber("+\(phoneNumberStr)")
            }
            else if phoneNumberStr.getSubString(offsetBy: 1) == "0" {
                phoneNumberStr.removeFirst(1)
                FirebaseAuthCustom.sharedInstance.verifyPhoneNumber("+84\(phoneNumberStr)")
            }
            if let presenter = presenter {
                presenter.pushInputCode(verificationIdString, phoneNumberStr)
            }
        }
    }
}

// MARK: - UITextFieldDelegate
extension InputPhoneNumberViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == phoneNumberTf {
            textField.resignFirstResponder()
        }
        return true
    }
}
