//
//  JourneyViewController.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 11/27/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps

enum JourneyViewControllerState {
    case enterAddress
    case createDepartureTime
    case reviewJourney
    case searchingJourney
    case chooseTime
    case editDepartureTime
}

class JourneyViewController: ViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var chooseTimeSectionView: UIView!
    @IBOutlet weak var chooseTimeWrapperView: UIView!
    @IBOutlet weak var mapWrapperView: UIView!
    @IBOutlet weak var enterAddressSectionView: UIView!
    @IBOutlet weak var searchingJourneySectionView: UIView!
    @IBOutlet weak var reviewJourneySectionView: UIView!
    @IBOutlet weak var backButtonSectionView: UIView!
    @IBOutlet weak var currentLocationWrapperView: UIView!
    
    @IBOutlet weak var enterAddressWrapperView: UIView!
    @IBOutlet weak var enterAddressPlaceholerWrapperView: UIView!
    
    @IBOutlet weak var iconSourceImageView: UIImageView!
    @IBOutlet weak var sourceAddressLb: UILabel!
    @IBOutlet weak var iconDestinationImageView: UIImageView!
    @IBOutlet weak var destinationAddressLb: UILabel!
    @IBOutlet weak var myAddressCollectionView: UICollectionView!
    @IBOutlet weak var createNowWrapperView: UIView!
    @IBOutlet weak var createNowTitleLb: UILabel!
    
    @IBOutlet weak var createPlanWrapperView: UIView!
    @IBOutlet weak var createPlanTitleLb: UILabel!
    
    @IBOutlet weak var reviewJourneyWrapperView: UIView!
    @IBOutlet weak var titleReviewJourneyLb: UILabel!
    
    @IBOutlet weak var departureIconImageView: UIImageView!
    @IBOutlet weak var departureTitleLb: UILabel!
    @IBOutlet weak var departureValueLb: UILabel!
    @IBOutlet weak var departureEditIconImageView: UIImageView!
    @IBOutlet weak var departureEditIconWrapperView: UIView!
    
    
    @IBOutlet weak var vehicleIconImageView: UIImageView!
    @IBOutlet weak var vehicleTitleLb: UILabel!
    @IBOutlet weak var vehicleValueLb: UILabel!
    
    @IBOutlet weak var priceIconImageView: UIImageView!
    @IBOutlet weak var priceTitleLb: UILabel!
    @IBOutlet weak var priceValueLb: UILabel!
    
    @IBOutlet weak var helmetIconImageView: UIImageView!
    @IBOutlet weak var helmetTitleLb: UILabel!
    @IBOutlet weak var helmetValueLb: UILabel!
    @IBOutlet weak var helmetWrapperView: UIView!
    @IBOutlet weak var helmetWrapperViewIconImageView: UIImageView!
    
    @IBOutlet weak var confirmWrapperView: UIView!
    @IBOutlet weak var confirmTitleLb: UILabel!

    @IBOutlet weak var searchingJourneyWrapperView: UIView!
    @IBOutlet weak var searchingTitlteLb: UILabel!
    @IBOutlet weak var lineSourceWrapperView: UIView!
    @IBOutlet weak var lineDestinationWrapperView: UIView!
    
    @IBOutlet weak var goHomeWrapperView: UIView!
    
    // Constraint
    @IBOutlet var reviewJourneyWrapperViewZeroConstraint: NSLayoutConstraint!
    @IBOutlet var reviewJourneyWrapperViewBottomSpaceConstraint: NSLayoutConstraint!
    
    @IBOutlet var enterAddressWrapperViewZeroConstraint: NSLayoutConstraint!
    @IBOutlet var enterAddressWrapperViewBottomSpaceConstraint: NSLayoutConstraint!
    
    @IBOutlet var searchingJourneyWrapperViewZeroConstraint: NSLayoutConstraint!
    @IBOutlet var searchingJourneyWrapperViewBottomSpaceConstraint: NSLayoutConstraint!
    
    @IBOutlet var createDepartureTimeWrapperViewZeroConstraint: NSLayoutConstraint!
    @IBOutlet var createDepartureTimeWrapperViewBottomSpaceConstraint: NSLayoutConstraint!
    
    @IBOutlet var myAddressWrapperViewZeroConstraint: NSLayoutConstraint!
    @IBOutlet var myAddressWrapperViewBottomSpaceConstraint: NSLayoutConstraint!
    
    
    @IBOutlet weak var chooseTimeWrapperViewZeroHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var chooseTimeWrapperViewBottomConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var asdasdasdkasdjk: NSLayoutConstraint!
    
    
    // MARK: - Properties
    var stateViewController: JourneyViewControllerState!
    var presenter: JourneyPresenterProtocol?
    @objc var builder: JourneyRequestBuilder!
    var extraInfo: [String: AnyObject] = [:]
    var info: GoogleGeocode? {
        didSet {
            updateView()
        }
    }
    private var isSelectedHelmet: Bool = false {
        didSet {
            if isSelectedHelmet != oldValue {
                didSetIsSelectedHelmet()
            }
        }
    }
    
    private var backgroundConfirmBtn: UIColor = UIColor.init()
    private var textColorTitlePlan: UIColor = UIColor.init()
    private let jetLocationmanager = JETLocationManager.sharedInstance
    private var myAddressView: MyAddressView?
    private var timeView: ChooseTimeView?
    
    private var mapView: GMSMapView!
    private var routeLine: GMSPolyline!
    private var path: GMSPath!
    private var sourceMarker: GMSMarker!
    private var destinationMarker: GMSMarker!
    
    // MARK: - Metadata
    override class func storyBoardId() -> String {
        return "JourneyViewController"
    }
    
    override class func storyBoardName() -> String {
        return "Journey"
    }
    
    // MARK: - View LyfeCycle
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
        
        setupView()
        addObserver()
    }
    
    func setupView() {
        setupUI()
        renderView()
        setupMapView()
        initPolyline()
        initMarker()
        
        viewDidLoadDepartureTimeViewController()
        viewDidLoadReviewJourneyViewControlelr()
        viewDidLoadChooseTimeViewController()
        viewDidLoadSearchingJourneyViewController()
        setupDirection()
    }
    
    func initPolyline() {
        routeLine = GMSPolyline.init()
        routeLine.strokeColor = ColorSystem.black
        routeLine.strokeWidth = 3
    }
    
    func initMarker() {
        if sourceMarker == nil {
            sourceMarker = GMSMarker.init()
            sourceMarker.icon = UIImage.init(assetId: .currentLocationBlackIcon)
        }
        if destinationMarker == nil {
            destinationMarker = GMSMarker.init()
            destinationMarker.icon = UIImage.init(assetId: .destination_icon)
        }
    }
    
    // MARK: - CreateDepartureTimeViewController
    func viewDidLoadDepartureTimeViewController() {
        if stateViewController == .createDepartureTime {
            ViewService.showLoadingIndicator()
            sourceAddressLb.textColor = ColorSystem.black
            destinationAddressLb.textColor = ColorSystem.black
            
            var sourceAddressStr: String = ""
            var destinationAddressStr: String = ""
            if let sourceAddress = extraInfo[Constants.sourceAddress] as? String,
                let destinationAddress = extraInfo[Constants.destinationAddress] as? String{
                sourceAddressStr = sourceAddress
                destinationAddressStr = destinationAddress
            }
            sourceAddressLb.text = sourceAddressStr
            destinationAddressLb.text = destinationAddressStr
            if let presenter = presenter {
                presenter.getDirection(query: QueryGoogleModel.init(origin: sourceAddressStr, destinationAddressStr))
            }
            
            createPlanWrapperView.isUserInteractionEnabled = true
            createNowWrapperView.isUserInteractionEnabled = true
            createNowWrapperView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(createNowWrapperView_DidTap)))
            createPlanWrapperView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(createPlanWrapperView_DidTap)))
        }
    }
    
    // MARK: - ReviewJourneyViewController
    func viewDidLoadReviewJourneyViewControlelr() {
        if stateViewController == .reviewJourney {
            ViewService.showLoadingIndicator()
            var dateStr: String = ""
            if let date = (builder.departureTime).asDate() {
                dateStr = date.asString(format: .hourDayMonthYear)
            }
            departureValueLb.text = dateStr
            departureEditIconWrapperView.isUserInteractionEnabled = builder.isPlan
            
            vehicleValueLb.text = "review.journey.vehicle.value.motobike".localized
            vehicleIconImageView.setImage(assetId: .motobikeIcon)
            vehicleIconImageView.alpha = 0.5
            
            priceIconImageView.setImage(assetId: .priceIcon)
            priceIconImageView.alpha = 0.5
            // price value get from server
            
            helmetValueLb.text = "review.journey.helmet.value".localized
            helmetIconImageView.setImage(assetId: .helmetIcon)
            helmetIconImageView.alpha = 0.5
            helmetWrapperViewIconImageView.setImage(assetId: .helmetChooseIcon)
            helmetWrapperView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(helmetWrapperView_DidTap)))
            
            setupDirection()
            
            // Get GlobalFee
            if let distance = extraInfo[Constants.distanceJourney] as? Int,
                let presenter = presenter {
                presenter.getGlobalFee(request: GlobalFeeRequest.init(distance: distance))
            }
        }
    }
    
    func setupDirection() {
        if let direction = extraInfo[Constants.direction] as? GoogleDirection {
            handlerGoogleDirection(direction)
        }
    }
    
    // MARK: - ChooseTimeViewController
    func viewDidLoadChooseTimeViewController() {
        if stateViewController == .chooseTime || stateViewController == .editDepartureTime {
            let view = ViewService.viewFrom(ChooseTimeView.nibName()) as! ChooseTimeView
            timeView = view
            chooseTimeWrapperView.addSubview(timeView!)
            timeView!.translatesAutoresizingMaskIntoConstraints = false
            let constraints: [NSLayoutConstraint] = [
                NSLayoutConstraint.init(item: timeView!, attribute: .trailing, relatedBy: .equal, toItem: chooseTimeWrapperView, attribute: .trailing, multiplier: 1, constant: 0),
                NSLayoutConstraint.init(item: timeView!, attribute: .top, relatedBy: .equal, toItem: chooseTimeWrapperView, attribute: .top, multiplier: 1, constant: 0),
                NSLayoutConstraint.init(item: timeView!, attribute: .bottom, relatedBy: .equal, toItem: chooseTimeWrapperView, attribute: .bottom, multiplier: 1, constant: 0),
                NSLayoutConstraint.init(item: timeView!, attribute: .leading, relatedBy: .equal, toItem: chooseTimeWrapperView, attribute: .leading, multiplier: 1, constant: 0)]
            chooseTimeWrapperView.addConstraints(constraints)
            timeView!.delegate = self
            chooseTimeSectionView.addShadow()
        }
        else {
            renderShowHideView(isShow: false, zeroConstraint: chooseTimeWrapperViewZeroHeightConstraint, chooseTimeWrapperViewBottomConstraint)
        }
    }
    
    // MARK: - SearchingViewControlelr
    func viewDidLoadSearchingJourneyViewController() {
        if stateViewController == .searchingJourney {
            if let direction = extraInfo[Constants.direction] as? GoogleDirection {
                handlerGoogleDirection(direction)
            }
        }
    }
    
    @objc func goHomeViewController() {
        if let navigationController = self.navigationController {
            let viewController = navigationController.viewControllers
            if let index = viewController.firstIndex(where: { (vc) -> Bool in
                if vc is ProvicePurposeViewController {
                    return true
                }
                return false
            }) {
                navigationController.popToViewController(viewController[index], animated: false)
                return
            }
        }
    }
    
    @objc func helmetWrapperView_DidTap() {
        /// open popup choose helmet
        if let presenter = presenter {
            presenter.showPopupHelmet(builder)
        }
    }
    
    @objc func createNowWrapperView_DidTap() {
        let date = Date()
        builder.departureTime = Int(date.timeIntervalSince1970)
        builder.isPlan = false
        setPhoneBuilder()
        if let presenter = presenter {
            presenter.pushJourney(state: .reviewJourney, builder, extraInfo)
        }
    }
    
    @objc func createPlanWrapperView_DidTap() {
        builder.isPlan = true
        setPhoneBuilder()
        if let presenter = presenter {
            // got to PickUpTime
            presenter.pushJourney(state: .chooseTime, builder, extraInfo)
        }
    }
    
    // set phone for builder
    func setPhoneBuilder() {
        var currentPhoneStr: String = ""
        if let currentPhone = AuthenticationService.currentPhone {
            currentPhoneStr = currentPhone
        }
        else {
            if builder.isPlan == true {
                ToastView.sharedInstance.showContent("Vui lòng cập nhập SĐT")
            }
        }
        builder.phoneNumber = currentPhoneStr
    }
    
    func addObserver() {
        addObserver(self, forKeyPath: #keyPath(builder.departureTime), options: [.new], context: nil)
    }
    
    deinit {
        removeObserver(self, forKeyPath: #keyPath(builder.departureTime))
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if let keyPath = keyPath {
            if keyPath == #keyPath(builder.departureTime) {
                DispatchQueue.main.async { [ weak self] in
                    if let weakSelf = self {
                        weakSelf.updateView()
                    }
                }
            }
            else {
                
            }
        }
    }
    
    
    
    func renderView() {
        renderEnterAddressWrapperView()
        renderReviewJourneyWrapperView()
        renderCreateDepartureTimeWrappreView()
        renderMyAddressWrapperView()
        renderSearchingJourneyWrapperView()
    }
    
    func setupMapView() {
        var currentLocationLat: Double = 10.8231
        var currentLocationLong: Double = 106.6297
        if let currentLocation = jetLocationmanager.currentLocation {
            currentLocationLat = currentLocation.coordinate.latitude
            currentLocationLong = currentLocation.coordinate.longitude
        }
        
        let camera = GMSCameraPosition.camera(withLatitude: currentLocationLat, longitude: currentLocationLong, zoom: 17)
        mapView = GMSMapView.map(withFrame: CGRect.init(x: 0, y: 0, width: ViewService.screenSize().width, height: ViewService.screenSize().height), camera: camera)
        mapWrapperView.addChildView(mapView)
        
        mapView.isMyLocationEnabled = true
    }
    
    func setupUI() {
        isSelectedHelmet = false
        mapWrapperView.layer.masksToBounds = true
        backgroundConfirmBtn = ColorSystem.currentPurposeColor()
        if let purpose = builder.userPurpose {
            if purpose == "user" {
                guard let iconSourceAddress = UIImage.init(assetId: .iconSourceUser) else { return }
                let tintIconSource = iconSourceAddress.withRenderingMode(.alwaysTemplate)
                iconSourceImageView.image = tintIconSource
                iconSourceImageView.tintColor = ColorSystem.green
                textColorTitlePlan = ColorSystem.black
            }
            else {
                iconSourceImageView.setImage(assetId: .iconSourceDriver)
                textColorTitlePlan = ColorSystem.green
            }
        }
        
        sourceAddressLb.text = "journey.source.address".localized
        sourceAddressLb.font = FontSystem.normalText
        sourceAddressLb.textColor = ColorSystem.blackOpacity
        lineSourceWrapperView.backgroundColor = ColorSystem.blackOpacity
        
        destinationAddressLb.text = "jouney.destination.address".localized
        destinationAddressLb.font = FontSystem.normalText
        destinationAddressLb.textColor = ColorSystem.blackOpacity
        lineDestinationWrapperView.backgroundColor = ColorSystem.blackOpacity
        
        createNowWrapperView.layer.cornerRadius = 10
        createNowWrapperView.backgroundColor = backgroundConfirmBtn
        createNowTitleLb.text = "journey.createnow.title".localized
        createNowTitleLb.font = FontSystem.buttonTitle
        createNowTitleLb.textColor = ColorSystem.white
        
        createPlanWrapperView.layer.borderWidth = 1
        createPlanWrapperView.layer.cornerRadius = 10
        createPlanWrapperView.layer.borderColor = backgroundConfirmBtn.cgColor
        createPlanWrapperView.backgroundColor = ColorSystem.white
        createPlanTitleLb.text = "journey.createplan.title".localized
        createPlanTitleLb.font = FontSystem.buttonTitle
        createPlanTitleLb.textColor = textColorTitlePlan
        
        titleReviewJourneyLb.text = "journey.title.reiview".localized
        titleReviewJourneyLb.font = FontSystem.sectionTitle
        titleReviewJourneyLb.textColor = ColorSystem.blackOpacity

        departureTitleLb.text = "journey.departuretime.title".localized
        departureTitleLb.font = FontSystem.subSectionTitle
        departureTitleLb.textColor = ColorSystem.blackOpacity
        departureIconImageView.setImage(assetId: .departureTimeIcon)
        departureIconImageView.alpha = 0.5
        departureEditIconImageView.setImage(assetId: .departureTimeEditIcon)
        departureEditIconImageView.alpha = 0.5
        departureEditIconWrapperView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(departureEditIconWrapperView_DidTap)))
        
        departureValueLb.textColor = ColorSystem.black
        departureValueLb.font = FontSystem.mediumText
        
        priceTitleLb.text = "journey.review.price.title".localized
        priceTitleLb.font = FontSystem.subSectionTitle
        priceTitleLb.textColor = ColorSystem.blackOpacity
        priceValueLb.textColor = ColorSystem.black
        priceValueLb.font = FontSystem.mediumText
        
        helmetTitleLb.text = "journey.review.helmet.title".localized
        helmetTitleLb.font = FontSystem.subSectionTitle
        helmetTitleLb.textColor = ColorSystem.blackOpacity
        
        helmetValueLb.textColor = ColorSystem.black
        helmetValueLb.font = FontSystem.mediumText
        
        vehicleTitleLb.text = "journey.reiview.vehicle.title".localized
        vehicleTitleLb.textColor = ColorSystem.blackOpacity
        vehicleTitleLb.font = FontSystem.subSectionTitle
        
        vehicleValueLb.text = "journey.review.vehicle.value".localized
        vehicleValueLb.font = FontSystem.mediumText
        vehicleValueLb.textColor = ColorSystem.black
        // add Tap
        // setImage
        
        confirmTitleLb.text = "journey.confirm.title".localized
        confirmTitleLb.font = FontSystem.buttonTitle
        confirmTitleLb.textColor = ColorSystem.white
        confirmWrapperView.layer.cornerRadius = 10
        confirmWrapperView.backgroundColor = backgroundConfirmBtn
        
        searchingJourneyWrapperView.layer.cornerRadius = 10
        searchingTitlteLb.text = "journey.searching.title".localized
        searchingTitlteLb.font = FontSystem.normalText
        searchingTitlteLb.textColor = ColorSystem.black
        
        backButtonSectionView.layer.cornerRadius = 10
        backButtonSectionView.addShadow()
        
        goHomeWrapperView.layer.cornerRadius = 10
        goHomeWrapperView.addShadow()
        goHomeWrapperView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(goHomeViewController)))
        
        enterAddressSectionView.layer.cornerRadius = 10
        reviewJourneyWrapperView.layer.cornerRadius = 10
        searchingJourneySectionView.layer.cornerRadius = 10
        
        createCurrentLocationView()
        
        setupUIGestureRecognizer()
        
    }
    
    @objc func departureEditIconWrapperView_DidTap() {
        // go to picker time
        if let presenter = presenter {
            presenter.pushJourney(state: .editDepartureTime, builder, extraInfo)
        }
    }
    
    func createCurrentLocationView() {
        if myAddressView == nil {
            let view = ViewService.viewFrom(MyAddressView.nibName()) as! MyAddressView
            myAddressView = view
            myAddressView!.delegate = self
            currentLocationWrapperView.addChildView(myAddressView!)
        }
    }
    
    func updateView() {
        if let info = info,
            let forrmattedAddress = info.formattedAddress {
            sourceAddressLb.text = forrmattedAddress
            sourceAddressLb.textColor = ColorSystem.black
            extraInfo.updateValue(forrmattedAddress as AnyObject, forKey: Constants.sourceAddress)
        }
        var dateStr: String = ""
        if let date = (builder.departureTime).asDate() {
            dateStr = date.asString(format: .hourDayMonthYear)
        }
        departureValueLb.text = dateStr
    }
    
    func didSetIsSelectedHelmet() {
        helmetValueLb.textColor = ColorSystem.black
        helmetTitleLb.textColor = ColorSystem.blackOpacity
        helmetIconImageView.setImage(assetId: .helmetIcon)
        helmetWrapperViewIconImageView.setImage(assetId: .helmetChooseIcon)
    }
    
    
    
    func setupUIGestureRecognizer() {
        backButtonSectionView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(backButtonSectionView_DidTap)))
        enterAddressPlaceholerWrapperView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(enterAddressPlaceholerWrapperView_Tap)))
        confirmWrapperView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(confirmWrapperView_DidTap)))
    }
    
    @objc func confirmWrapperView_DidTap() {
        if let presenter = presenter {
            if isSelectedHelmet == false {
                // chua chon non
                presenter.showPopupHelmet(builder)
                errorNonChooseHelmet()
            }
            else {
                // chon non roi
                // go to Searching
                // post create journey
                presenter.createJourney(builder)
            }
        }
    }
    
    func errorNonChooseHelmet() {
        if let helmetIcon = UIImage.init(assetId: .errorNonHelmetIcon),
            let helmetChooseIcon = UIImage.init(assetId: .helmetChooseIcon) {
            let tintHelmet = helmetIcon.withRenderingMode(.alwaysTemplate)
            let tintChooseIcon = helmetChooseIcon.withRenderingMode(.alwaysTemplate)
            helmetIconImageView.image = tintHelmet
            helmetWrapperViewIconImageView.image = tintChooseIcon
        }
        helmetIconImageView.tintColor = ColorSystem.red
        helmetWrapperViewIconImageView.tintColor = ColorSystem.red
        helmetValueLb.textColor = ColorSystem.red
        helmetTitleLb.textColor = ColorSystem.red
    }
    
    @objc func backButtonSectionView_DidTap() {
        self.popViewController()
    }
    
    @objc func enterAddressPlaceholerWrapperView_Tap() {
        if let presenter = presenter, let builder = builder {
            presenter.pushChooseAddress(extraInfo, builder)
        }
    }
    
//    func popViewController() {
//        if let navigationController = navigationController {
//            let viewControllers = navigationController.viewControllers
//            if let index = viewControllers.index(of: self), index > 0 {
//                navigationController.popViewController(animated: true)
//            }
//        }
//    }
    
    // MARK: - Render Section View
    func renderEnterAddressWrapperView() {
        if stateViewController == .enterAddress || stateViewController == .createDepartureTime {
            renderShowHideEnterAddressWrapperView(isShow: true)
            enterAddressWrapperView.layer.cornerRadius = 10
            enterAddressSectionView.addShadow()
        }
        else {
            renderShowHideEnterAddressWrapperView(isShow: false)
        }
    }
    
    func renderReviewJourneyWrapperView() {
        if stateViewController == .reviewJourney {
            renderShowHideReviewJourneyWrapperView(isShow: true)
            reviewJourneySectionView.addShadow()
        }
        else {
            renderShowHideReviewJourneyWrapperView(isShow: false)
        }
    }
    
    func renderSearchingJourneyWrapperView() {
        if stateViewController == .searchingJourney {
            renderShowHideSearchingJourneyWrapperView(isShow: true)
            searchingJourneySectionView.addShadow()
        }
        else {
            renderShowHideSearchingJourneyWrapperView(isShow: false)
        }
    }
    
    func renderCreateDepartureTimeWrappreView() {
        if stateViewController == .createDepartureTime {
            renderShowHideCreateDepartureTimeWrapperView(isShow: true)
            enterAddressSectionView.addShadow()
        }
        else {
            renderShowHideCreateDepartureTimeWrapperView(isShow: false)
        }
    }
    
    func renderMyAddressWrapperView() {
        if stateViewController == .enterAddress {
            renderShowHideMyAddressWrapperView(isShow: false)
        }
        else {
            renderShowHideMyAddressWrapperView(isShow: false)
        }
    }
    
    func renderShowHideEnterAddressWrapperView(isShow: Bool) {
        renderShowHideView(isShow: isShow, zeroConstraint: enterAddressWrapperViewZeroConstraint, enterAddressWrapperViewBottomSpaceConstraint)
    }
    
    func renderShowHideReviewJourneyWrapperView(isShow: Bool) {
        renderShowHideView(isShow: isShow, zeroConstraint: reviewJourneyWrapperViewZeroConstraint, reviewJourneyWrapperViewBottomSpaceConstraint)
    }
    
    func renderShowHideSearchingJourneyWrapperView(isShow: Bool) {
        renderShowHideView(isShow: isShow, zeroConstraint: searchingJourneyWrapperViewZeroConstraint, searchingJourneyWrapperViewBottomSpaceConstraint)
    }
    
    func renderShowHideCreateDepartureTimeWrapperView(isShow: Bool) {
        renderShowHideView(isShow: isShow, zeroConstraint: createDepartureTimeWrapperViewZeroConstraint, createDepartureTimeWrapperViewBottomSpaceConstraint)
    }
    
    func renderShowHideMyAddressWrapperView(isShow: Bool) {
        renderShowHideView(isShow: isShow, zeroConstraint: myAddressWrapperViewZeroConstraint, myAddressWrapperViewBottomSpaceConstraint)
    }
    
    func renderShowHideView(isShow: Bool, zeroConstraint: NSLayoutConstraint,_ bottomSpaceConstraint: NSLayoutConstraint) {
        zeroConstraint.isActive = !isShow
        bottomSpaceConstraint.isActive = isShow
    }
    
    // MARK: - Handle Direction(polyline, marker)
    func handlerGoogleDirection(_ direction: GoogleDirection) {
        extraInfo.updateValue(direction as AnyObject, forKey: Constants.direction)
        let route = direction.routes[0]
        let leg = route.legs[0]
        
        // update polyline
        if let polyline = route.overviewPolyline,
            let path = GMSPath.init(fromEncodedPath: polyline.points) {
            routeLine.path = path
            routeLine.map = mapView
        }
        else {
            routeLine.path = nil
            routeLine.map = nil
        }
        
        if let startLocation = leg.startLocation,
            let endLocation = leg.endLocation {
            //update marker
            let sourceLocation = CLLocationCoordinate2D.init(latitude: startLocation.lat, longitude: startLocation.lng)
            let destinationLocation = CLLocationCoordinate2D.init(latitude: endLocation.lat, longitude: endLocation.lng)
            sourceMarker.position = sourceLocation
            destinationMarker.position = destinationLocation
            // show to mapView
            sourceMarker.map = mapView
            destinationMarker.map = mapView
            
            /// udpate camera
            let bounds = GMSCoordinateBounds.init(coordinate: CLLocationCoordinate2D.init(latitude: startLocation.lat, longitude: startLocation.lng), coordinate: CLLocationCoordinate2D.init(latitude: endLocation.lat, longitude: endLocation.lng))
            let update = GMSCameraUpdate.fit(bounds, with: UIEdgeInsets.init(top: 75, left: 75, bottom: 250, right: 75))
            mapView.animate(with: update)
            mapView.isMyLocationEnabled = false
            
            // setDistance
            let distance = leg.distance.value
            extraInfo.updateValue(distance as AnyObject, forKey: Constants.distanceJourney)
        }
    }
}

// MARK: - JourneyViewProtocol
extension JourneyViewController: JourneyViewProtocol {
    // MARK: CreateJourney
    func didCreateJourneySuccess(_ journey: Journey) {
        if builder.isPlan == true {
            ToastView.sharedInstance.showContent("Tạo lộ trình thành công.")
            popToProvicePurposeViewController()
        }
        else {
            if let presenter = presenter {
                presenter.pushJourney(state: .searchingJourney, builder, extraInfo)
                // init current journey
            }
        }
    }
    
    func didCreateJourneyFail() {
        
    }
    
    // MARK: CurrentAddress
    func didGetCurrentAddressSuccess(info: GoogleGeocode) {
        self.info = info
        ViewService.hideLoadingIndicator()
    }
    
    func didGetCurrentAddressFail() {
        ViewService.hideLoadingIndicator()
        ToastView.sharedInstance.showContent("Không xác định được vị trí của bạn")
    }
    
    // MARK: Direction
    func didGetDirectionSuccess(googleDirection: GoogleDirection) {
        if let requestID = googleDirection.directionRequestId {
            builder.directionRequestID = requestID
        }
        handlerGoogleDirection(googleDirection)
        ViewService.hideLoadingIndicator()
    }
    
    func didGetDirectionFail() {
        ViewService.hideLoadingIndicator()
    }
    
    // MARK: Global Fee
    func didGetGlobalFeeSuccess(_ totalFee: Float) {
        ViewService.hideLoadingIndicator()
        priceValueLb.text = (totalFee as NSNumber).asCurrencyString()
    }
    
    func didGetGlobalFeeFail() {
        ViewService.hideLoadingIndicator()
        priceValueLb.text = "review.journey.error.globalfee".localized
    }
}

// MARK: - JETLocationManagerDelegate
extension JourneyViewController: JETLocationManagerDelegate {
    func locationManagerCannotFetchCurrentLocation() {
        
    }
    
    func locationManagerDidFetchCurrentLocation(_ location: CLLocation) {
        
    }
}

// MARK: - ChooseTimeViewDelegate
extension JourneyViewController: ChooseTimeViewDelegate {
    func chooseTimeViewDidTapConfirm(from view: ChooseTimeView, date: Date) {
        builder.departureTime = Int(date.timeIntervalSince1970)
        if let presenter = presenter {
            if stateViewController == .editDepartureTime {
                self.popViewController()
            }
            else {
                presenter.pushJourney(state: .reviewJourney, builder, extraInfo)
            }
        }
    }
}

// MARK: - MyAddressViewDelegate
extension JourneyViewController: MyAddressViewDelegate {
    func myAddressViewDelegateDidTapCurrentLocationWrapperView(from view: MyAddressView) {
        if let presenter = presenter {
            ViewService.showLoadingIndicator()
            presenter.getCurrentAddress()
        }
    }
}

extension JourneyViewController: PopupHelmetViewControllerDelegate {
    func popupHelmetViewControllerDidTapConfirmHelmet(from viewController: PopupHelmetViewController, isHelmet: Bool) {
        switch isHelmet {
        case true:
            helmetValueLb.text = "review.journey.helmet.value.yes".localized
            if builder.userPurpose == "user" {
                builder.userPurpose = PurposeType.helmetUser.rawValue
            }
            else {
                builder.userPurpose = PurposeType.helmetDriver.rawValue
            }
        case false:
            helmetValueLb.text = "review.journey.helmet.value.no".localized
            if builder.userPurpose == "user" {
                builder.userPurpose = PurposeType.nonHelmetUser.rawValue
            }
            else {
                builder.userPurpose = PurposeType.nonHelmetDriver.rawValue
            }
        }
        isSelectedHelmet = true
    }
}
