//
//  PikcUpTimeViewController.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 11/3/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import UIKit

class PickUpTimeViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var titlePickupTimeLb: UILabel!
    
    //Date
    @IBOutlet weak var currentDateWrapperView: UIView!
    @IBOutlet weak var currentDateLb: UILabel!
    
    @IBOutlet weak var nextDateWrapperView: UIView!
    @IBOutlet weak var nextDateLb: UILabel!
    
    @IBOutlet weak var futureDateWrapperView: UIView!
    @IBOutlet weak var futureDateLb: UILabel!
    
    
    @IBOutlet weak var confirmWrapperView: UIView!
    @IBOutlet weak var timePicker: UIDatePicker!
    
    
    // MARK: - Properties
    var presenter: PickUpTimePresenterProtocol?
    var extraInfo: [String: AnyObject] = [:]
    var builder: JourneyRequestBuilder!
    var now = Date()
    var nextDate = Date().addingTimeInterval(24*3600.0)
    var nextnextDate = Date().addingTimeInterval(2*24*3600.0)
    var dateFormatter = DateFormatter()
    let calendar = Calendar.init(identifier: .gregorian)
    let timeInterval = 24*3600.0
    var hourStr: String = ""
    var minuteStr: String = ""
    var dateComponent = DateComponents()
    
    // MARK: - MetaData
    class func storyBoardId() -> String {
        return "PickUpTimeViewController"
    }
    
    class func storyBoardName() -> String {
        return "PickUpTime"
    }
    
    // MARK: - View lyfe cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupTime()
        addGesture()
    }
    
    // MARK: - Method
    func setupUI() {
//        dateFormatter.locale = .init(identifier: "vi_VN")
        dateFormatter.dateFormat = "hh:mm"
        dateFormatter.timeZone = TimeZone.current
        timePicker.timeZone = TimeZone.current
        hourStr = dateFormatter.string(from: timePicker.date)
        dateComponent.timeZone = TimeZone.current
    }
    
    func addGesture() {
        currentDateWrapperView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(currentDateWrapperView_Tap)))
        nextDateWrapperView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(nextDateWrapperView_Tap)))
        futureDateWrapperView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(futureDateWrapperView_Tap)))
        confirmWrapperView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(confirmWrapperView_Tap)))
        
        timePicker.addTarget(self, action: #selector(timePicker_DidScroll(sender:)), for: .valueChanged)
        
    }
    
    func setupTime() {
        let nextDate = now.addingTimeInterval(timeInterval)
        let futureDate = nextDate.addingTimeInterval(timeInterval)
        currentDateLb.text = "\(getDayOfWeek())\n\(getDay())\n\(getMonth())"
        nextDateLb.text = "\(getDayOfWeek(nextDate))\n\(getDay(nextDate))\n\(getMonth(nextDate))"
        futureDateLb.text = "\(getDayOfWeek(futureDate))\n\(getDay(futureDate))\n\(getMonth(futureDate))"
    }
    
    // MARK: - Func of Gesture
    
    @objc func timePicker_DidScroll(sender: UIDatePicker) {
//        dateFormatter.locale = .init(identifier: "vi_VN")
        dateFormatter.dateFormat = "HH"
        hourStr = dateFormatter.string(from: timePicker.date)
        dateComponent.hour = Int.init(hourStr)
        
        dateFormatter.dateFormat = "mm"
        minuteStr = dateFormatter.string(from: timePicker.date)
        dateComponent.minute = Int.init(minuteStr)
        
        print("TimePicker: \(timePicker.date)")
    }
    
    //date
    @objc func currentDateWrapperView_Tap() {
        setComponentDate(now)
        
        currentDateWrapperView.backgroundColor = .darkGray
        nextDateWrapperView.backgroundColor = .gray
        futureDateWrapperView.backgroundColor = .gray
    }
    
    @objc func nextDateWrapperView_Tap() {
        setComponentDate(nextDate)
        
        
        currentDateWrapperView.backgroundColor = .gray
        nextDateWrapperView.backgroundColor = .darkGray
        futureDateWrapperView.backgroundColor = .gray
    }
    
    //
    func setComponentDate(_ date: Date) {
        dateFormatter.dateFormat = "dd"
        dateComponent.day = Int.init(dateFormatter.string(from: date))
        dateFormatter.dateFormat = "MM"
        dateComponent.month = Int.init(dateFormatter.string(from: date))
    }
    
    @objc func futureDateWrapperView_Tap() {
        setComponentDate(nextnextDate)
        
        currentDateWrapperView.backgroundColor = .gray
        nextDateWrapperView.backgroundColor = .gray
        futureDateWrapperView.backgroundColor = .darkGray
    }
    
    @objc func confirmWrapperView_Tap() {
        var calendar = Calendar.current
        calendar.timeZone = TimeZone.current
        dateFormatter.timeZone = TimeZone.current
        
        dateFormatter.dateFormat = "HH"
        hourStr = dateFormatter.string(from: timePicker.date)
        dateComponent.hour = Int.init(hourStr)
        
        dateFormatter.dateFormat = "mm"
        minuteStr = dateFormatter.string(from: timePicker.date)
        dateComponent.minute = Int.init(minuteStr)
        
        dateComponent.year = Int.init(getCurrentYear())
        let newDate = calendar.date(from: dateComponent)
        
        if let newDate = newDate {
            builder.departureTime = Int(newDate.timeIntervalSince1970)
        }
        if let presenter = presenter {
            presenter.pushSearchJourey(builder, extraInfo)
        }
        dateFormatter.dateFormat = "EEEE-dd-MM-yyyy hh:mm a"
        print("NewDate: \(dateFormatter.string(from: newDate!))")
        print("Now: \(dateFormatter.string(from: now))")
        print("")
    }
    
    // MARK: - func get component of time.
    func getDayOfWeek(_ date: Date = Date()) -> String {
        dateFormatter.dateFormat = "EEEE"
        return dateFormatter.string(from: date)
    }
    
    func getDay(_ date: Date = Date()) -> String {
        dateFormatter.dateFormat = "dd"
        return dateFormatter.string(from: date)
    }
    
    func getMonth(_ date: Date = Date()) -> String {
        dateFormatter.dateFormat = "MM"
        return dateFormatter.string(from: date)
    }
    
    func getCurrentYear() -> String {
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: Date())
    }
    
}

// MARK: - PickUpTimeViewProtocol
extension PickUpTimeViewController: PickUpTimeViewProtocol {
    
}

extension String {
    func asDate() -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "EEEE-dd-MM-yyyy hh:mm"
        
        return dateFormatter.date(from: self) ?? Date()
    }
}



