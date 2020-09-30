//
//  ChooseTimeView.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 12/11/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import UIKit

enum StateView {
    case today
    case nextday
    case thirdday
}

protocol ChooseTimeViewDelegate: class {
    func chooseTimeViewDidTapConfirm(from view: ChooseTimeView, date: Date)
}

class ChooseTimeView: UIView {
    
    // MARK: - IBOutlets
    @IBOutlet weak var contentWrapperView: UIView!
    
    @IBOutlet weak var titleChooseDayLb: UILabel!
    
    @IBOutlet weak var todayWrapperView: UIView!
    @IBOutlet weak var todayLb: UILabel!
    @IBOutlet weak var todayCheckWrapperView: UIView!
    
    @IBOutlet weak var nextDayWrapperView: UIView!
    @IBOutlet weak var nextDayLb: UILabel!
    @IBOutlet weak var nextDayCheckWrapperView: UIView!
    
    @IBOutlet weak var thirdDayWrapperView: UIView!
    @IBOutlet weak var thirdDayLb: UILabel!
    @IBOutlet weak var thirdDayCheckWrapperView: UIView!
    
    @IBOutlet weak var titleChooseHourLb: UILabel!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var placeHolderDatePickerView: UIView!
    
    @IBOutlet weak var confirmWrapperView: UIView!
    @IBOutlet weak var confirmTitleLb: UILabel!
    
    // MARK: - Properties
    private var backgroundBtn: UIColor = ColorSystem.currentPurposeColor()
    private var isSelectedDay: Bool = false
    private var stateView: StateView! {
        didSet {
            didSetStateView()
        }
    }
    weak var delegate: ChooseTimeViewDelegate?
    private var dateComponent: DateComponents = DateComponents.init()
    let timeIntervalOneDay: Double = 24*60*60
    private var today: Date!
    private var nextday: Date!
    private var thirdday: Date!
    private var newDate: Date!
    
    // MARK: - NibName
    class func nibName() -> String {
        return "ChooseTimeView"
    }
    
    // MARK: - LifeCycle
    override func awakeFromNib() {
        super.awakeFromNib()
        
        setupUI()
    }

    func setupUI() {
        
        contentWrapperView.layer.cornerRadius = 10

        titleChooseDayLb.text = "choosetime.title.day".localized
        titleChooseDayLb.textColor = ColorSystem.blackOpacity
        titleChooseDayLb.font = FontSystem.sectionTitle
        
        titleChooseHourLb.text = "choosetime.title.hour".localized
        titleChooseHourLb.textColor = ColorSystem.blackOpacity
        titleChooseHourLb.font = FontSystem.sectionTitle
        
        let listView: [UIView] = [todayWrapperView, nextDayWrapperView, thirdDayWrapperView]
        for view in listView {
            view.layer.cornerRadius = 10
            view.layer.borderColor = ColorSystem.blackOpacity.cgColor
            view.layer.borderWidth = 0.5
            view.backgroundColor = ColorSystem.white
        }
        
        let listCheckView: [UIView] = [todayCheckWrapperView, nextDayCheckWrapperView, thirdDayCheckWrapperView]
        for view in listCheckView {
            view.layer.cornerRadius = 12
            view.alpha = 0
        }
        
        // GestureRecognizer
        todayWrapperView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(todayWrapperView_DidTap)))
        nextDayWrapperView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(nextDayWrapperView_DidTap)))
        thirdDayWrapperView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(thirdDayWrapperView_DidTap)))
        datePicker.addTarget(self, action: #selector(datePicker_DidScroll(sender:)), for: .valueChanged)
        
        placeHolderDatePickerView.backgroundColor = ColorSystem.greenBGOpacity
        placeHolderDatePickerView.layer.cornerRadius = 10
        
        datePicker.textColor = ColorSystem.black
        datePicker.hideSelectionsIndicator()
        
        confirmWrapperView.layer.cornerRadius = 10
        confirmWrapperView.backgroundColor = backgroundBtn
        confirmWrapperView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(confirmWrapperView_DidTap)))
        confirmTitleLb.text = "choosetime.confirm.title".localized
        confirmTitleLb.textColor = ColorSystem.white
        confirmTitleLb.font = FontSystem.buttonTitle
        
        setupDataTime()
    }
    
    func setupDataTime() {
        today = Date()
        nextday = today.addingTimeInterval(timeIntervalOneDay)
        thirdday = nextday.addingTimeInterval(timeIntervalOneDay)
        
        // Thứ hai, ngày 20/12/2019 exp
        let todayStr: String = today.asString(format : .dayofweek) + ", ngày " + today.asString(format: .dayMonthYear)
        let nextdayStr: String = nextday.asString(format: .dayofweek) + ", ngày " + nextday.asString(format: .dayMonthYear)
        let thirddayStr: String = thirdday.asString(format: .dayofweek) + ", ngày " + thirdday.asString(format: .dayMonthYear)
        
        todayLb.text = todayStr
        nextDayLb.text = nextdayStr
        thirdDayLb.text = thirddayStr
    }
    
    func didSetStateView() {
        isSelectedDay = true
        renderTodayWrapperView()
        renderNextdayWrapperView()
        renderThirddayWrapperView()
        
        setDateComponentsToday()
        setDateComponentsNextday()
        setDateComponentsThirdday()
        setNewDate()
    }
    
    // MARK: - Method
    func setNewDate() {
        var calendar: Calendar = Calendar.current
        calendar.timeZone = TimeZone.current
        dateComponent.hour = Int(datePicker.date.asString(format: .hour))
        dateComponent.minute = Int(datePicker.date.asString(format: .minute))
        dateComponent.year = Int(today.asString(format: .year))
        
        if let newDate = calendar.date(from: dateComponent) {
            self.newDate = newDate
        }
    }
    
    func setDateComponentsToday() {
        if stateView == .today {
            setDateComponents(today)
        }
    }
    
    func setDateComponentsNextday() {
        if stateView == .nextday {
            setDateComponents(nextday)
        }
    }
    
    func setDateComponentsThirdday() {
        if stateView == .thirdday {
            setDateComponents(thirdday)
        }
    }
    
    func setDateComponents(_ date: Date) {
        dateComponent.day = Int(date.asString(format: .day))
        dateComponent.month = Int(date.asString(format: .month))
    }
    
    func renderTodayWrapperView() {
        if stateView == .today {
            renderWrapperView_DidTap(wrapperView: todayWrapperView, todayCheckWrapperView, alpha: 1, backgroundColor: ColorSystem.greenBGOpacity, borderWithColor: ColorSystem.green)
        }
        else {
            renderWrapperView_DidTap(wrapperView: todayWrapperView, todayCheckWrapperView, alpha: 0, backgroundColor: ColorSystem.white, borderWithColor: ColorSystem.blackOpacity)
        }
    }
    
    func renderNextdayWrapperView() {
        if stateView == .nextday {
            renderWrapperView_DidTap(wrapperView: nextDayWrapperView, nextDayCheckWrapperView, alpha: 1, backgroundColor: ColorSystem.greenBGOpacity, borderWithColor: ColorSystem.green)
        }
        else {
            renderWrapperView_DidTap(wrapperView: nextDayWrapperView, nextDayCheckWrapperView, alpha: 0, backgroundColor: ColorSystem.white, borderWithColor: ColorSystem.blackOpacity)
        }
    }
    
    func renderThirddayWrapperView() {
        if stateView == .thirdday {
            renderWrapperView_DidTap(wrapperView: thirdDayWrapperView, thirdDayCheckWrapperView, alpha: 1, backgroundColor: ColorSystem.greenBGOpacity, borderWithColor: ColorSystem.green)
        }
        else {
            renderWrapperView_DidTap(wrapperView: thirdDayWrapperView, thirdDayCheckWrapperView, alpha: 0, backgroundColor: ColorSystem.white, borderWithColor: ColorSystem.blackOpacity)
        }
    }
    
    func renderWrapperView_DidTap(wrapperView: UIView,_ checkWrappView: UIView,alpha: CGFloat, backgroundColor: UIColor, borderWithColor: UIColor) {
        checkWrappView.alpha = alpha
        wrapperView.backgroundColor = backgroundColor
        wrapperView.layer.borderColor = borderWithColor.cgColor
    }
    
    // MARK: - GestureRecognizer
    @objc func datePicker_DidScroll(sender: UIDatePicker) {
        setNewDate()
        print("DidScroll: \(datePicker.date.asString(format: .hourDayMonthYear))")
    }
    
    @objc func todayWrapperView_DidTap() {
        stateView = .today
    }
    
    @objc func nextDayWrapperView_DidTap() {
        stateView = .nextday
    }
    
    @objc func thirdDayWrapperView_DidTap() {
        stateView = .thirdday
    }
    
    @objc func confirmWrapperView_DidTap() {
        if isSelectedDay == false || newDate == nil {
            ToastView.sharedInstance.showContent("Bạn chưa chọn ngày cho chuyến đi!")
        }
        else {
            // return review journey
            print("Touch: \(datePicker.date.asString(format: .hourDayMonthYear))")
            print("NewDate: \(newDate.asString(format: .hourDayMonthYear))")
            if let delegate = delegate {
                delegate.chooseTimeViewDidTapConfirm(from: self, date: newDate)
            }
        }
    }
}
