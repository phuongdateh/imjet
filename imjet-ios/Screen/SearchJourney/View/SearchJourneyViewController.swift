//
//  SearchJourneyViewController.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 10/26/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import UIKit
import RealmSwift

class SearchJourneyViewController: ViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var sourceAddressLb: UILabel!
    @IBOutlet weak var destinationAddressLb: UILabel!
    
    @IBOutlet weak var mapWrapperView: UIView!
    @IBOutlet weak var infoJourneyWrapperView: UIView!
    
    @IBOutlet weak var departureTimeLbl: UILabel!
    @IBOutlet weak var totalFeeLb: UILabel!
    
    @IBOutlet weak var chooseHalmetLb: UILabel!

    @IBOutlet weak var timeJourneyWrapperView: UIView!
    
    @IBOutlet weak var infoMoneyHalmetWrapperView: UIView!
    @IBOutlet weak var searchWrapperView: UIView!
    
    @IBOutlet weak var paymentMethodAndSeatWrapperView: UIView!
    
    @IBOutlet weak var helmetWrapperView: UIView!
    @IBOutlet weak var nonHelmetWrapperView: UIView!
    
    @IBOutlet weak var searchTitleLb: UILabel!

    
    // MARK: - Properties
    var journey: Journey?
    var presenter: SearchJourneyPresenterProtocol?
    var extraInfo: [String: AnyObject] = [:]
    var builder: JourneyRequestBuilder!
    var userPurpose: PurposeType!
    private var totalFee: Float!
    private var mapView: CustomMapView!
    
    // MARK: - Metadata
    override class func storyBoardId() -> String {
        return "SearchJourneyViewController"
    }
    
    override class func storyBoardName() -> String {
        return "SearchJourney"
    }
    
    // MARK: - Lyfe Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        addGestureRecognizer()
        setupData()
        
    }
    
    // MARK: - Method
    func setupUI() {
        timeJourneyWrapperView.addCornerRadiusAndBorderWidth(cornerRadius: 10, borderColor: .black, borderWidth: 0)
        searchWrapperView.addCornerRadiusAndBorderWidth(cornerRadius: 0, borderColor: .black, borderWidth: 1)
        helmetWrapperView.addCornerRadiusAndBorderWidth(cornerRadius: 10, borderColor: .black, borderWidth: 1)
        nonHelmetWrapperView.addCornerRadiusAndBorderWidth(cornerRadius: 10, borderColor: .black, borderWidth: 1)
        totalFeeLb.text = "Số tiền: "
        helmetWrapperView.backgroundColor = .clear
        nonHelmetWrapperView.backgroundColor = .clear
        
        initMapView()
        
        
    }
    
    func addGestureRecognizer() {
        searchWrapperView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(searchWrapperView_Tap)))
        helmetWrapperView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(halmetWrapperView_Tap)))
        nonHelmetWrapperView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(nonHalmetWrapperView_Tap)))
    }
    
    func initMapView() {
        if mapView == nil {
            let view = CustomMapView.init(height: ViewService.screenSize().height - 349 - 44)
            mapView = view
            mapWrapperView.addChildView(mapView)
            if let startLocation = extraInfo["startLocation"] as? GoogleDirectionLegLocation, let endLocation = extraInfo["endLocation"] as? GoogleDirectionLegLocation {
                mapView.cleanAllMaker()
                mapView.updatePolyline(overviewPolyline: extraInfo["overviewPolyline"] as? String)
                mapView.setPositionSourceMarker(startLocation)
                mapView.setPositionDestination(endLocation)
            }
        }
    }
    
    func setupData() {
        if let source = extraInfo["source"] as? String, let destination = extraInfo["destination"] as? String {
            sourceAddressLb.text = source
            destinationAddressLb.text = destination
        }
        if let distance = extraInfo["distance"] as? Int, let presenter = presenter {
            let requestGlobal = GlobalFeeRequest.init(distance: distance)
            presenter.getGlobalFee(requestGlobal)
        }
    }
    
    func updateUI() {
        totalFeeLb.text = "Số tiền: \(totalFee.description) đ"
    }
    
    func isUser() -> Bool {
        if builder.userPurpose == "user" {
            return true
        }
        return false
    }
    
    @objc func searchWrapperView_Tap() {
        if helmetWrapperView.backgroundColor == .clear && nonHelmetWrapperView.backgroundColor == .clear {
            ToastView.sharedInstance.showContent("Bạn vui lòng chọn nón.")
        }
        else {
            if let presenter = presenter {
                presenter.createJourney(builder)
            }
            searchTitleLb.text = "Đang tìm kiếm"
        }
        
        
    }
    
    @objc func halmetWrapperView_Tap() {
        helmetWrapperView.backgroundColor = .black
        nonHelmetWrapperView.backgroundColor = .clear
        
        if isUser() == true {
            builder.userPurpose = PurposeType.helmetUser.rawValue
        }
        else {
            builder.userPurpose = PurposeType.helmetDriver.rawValue
        }
    }
    
    @objc func nonHalmetWrapperView_Tap() {
        nonHelmetWrapperView.backgroundColor = .black
        helmetWrapperView.backgroundColor = .clear
        
        if isUser() == true {
            builder.userPurpose = PurposeType.nonHelmetUser.rawValue
        }
        else {
            builder.userPurpose = PurposeType.nonHelmetDriver.rawValue
        }
    }
    
}

// MARK: - SearchJourneyViewProtocol
extension SearchJourneyViewController: SearchJourneyViewProtocol {
    func didGetGlobalFeeSuccess(_ totalFee: Float) {
        self.totalFee = totalFee
        updateUI()
    }
    
    func didGetGlobalFeeFail() {
        totalFeeLb.text = "..."
    }
    
    func didCreateJourneySuccess(_ journey: Journey) {
        self.journey = journey
        if let journey = self.journey {
            let departureTimestamp = journey.departureTimestamp
            let date = Date(timeIntervalSince1970: TimeInterval(departureTimestamp))
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "dd-MM-yyyy h:mm a"
            let strDate = dateFormatter.string(from: date)
            departureTimeLbl.text = "Thời gian: \(strDate)"
        }
        ToastView.sharedInstance.showContent("Tạo lộ trình thành công")
        if builder.isPlan == true {
            if let navigationController = navigationController {
                let viewControllers = navigationController.viewControllers
                if let index = viewControllers.firstIndex(where: { (vc) -> Bool in
                    if vc is ProvicePurposeViewController {
                        return true
                    }
                    return false
                }) {
                    navigationController.popToViewController(viewControllers[index], animated: true)
                    return
                }
            }
        }
    }
    
    func didCreateJourneyFail() {
        searchTitleLb.text = "Tìm kiếm"
    }
}
