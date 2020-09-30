//
//  SearchAddressViewController.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 8/27/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps
import CoreLocation

class SearchAddressViewController: ViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var startAddressWrapperView: UIView!
    @IBOutlet weak var startAddressLb: UILabel!
    @IBOutlet weak var destinationWrapperView: UIView!
    @IBOutlet weak var destinationTf: UITextField!
    
    @IBOutlet weak var menuWrapperView: UIView!
    @IBOutlet weak var menuImageView: UIImageView!
    
    @IBOutlet weak var mapWrapperView: UIView!
    
    // MARK: - Properties
    var launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    var settingBarButton: UIBarButtonItem?
    var presenter: SearchAddressPresenterProtocol?
    private var sourceMarker: GMSMarker!
    private var destinationMaker: GMSMarker!
    private var mapView: GMSMapView!
    private let jetLocationmanager = JETLocationManager.sharedInstance
    private var infoGeoCode: GoogleGeocode!
    var builder: JourneyRequestBuilder!
    
    // MARK: - Metadata
    override class func storyBoardId() -> String {
        return "SearchAddressViewController"
    }
    
    override class func storyBoardName() -> String {
        return "SearchAddress"
    }
    
    
    override func loadView() {
        super.loadView()
        
        
    }
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.gray
        
//        locationManager.requestWhenInUseAuthorization()
//        locationManager.delegate = self
//        locationManager.startUpdatingLocation()
        
        
        
        
        startAddressWrapperView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(startAddressWrapperView_Tap)))
        destinationTf.delegate = self
        destinationTf.returnKeyType = .search
        
        
        destinationWrapperView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(destinationWrapperView_Tap)))
        menuWrapperView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(menuWrapperView_Tap)))
        menuWrapperView.layer.masksToBounds = true
        menuImageView.image = UIImage.init(assetId: .hamberger_menu)
        
        
        createMapView()
        jetLocationmanager.delegate = self
        jetLocationmanager.startGettingLocation()
        
        
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
    }
    
    // MARK: - Method
    
    fileprivate func navigateChooseAddress() {
        if let presenter = presenter {
            if infoGeoCode == nil {
                infoGeoCode = GoogleGeocode()
            }
            presenter.pushChooseAddress(info: infoGeoCode, builder)
        }
    }
    
    @objc func startAddressWrapperView_Tap() {
        navigateChooseAddress()
    }
    
    @objc func menuWrapperView_Tap() {
        if let presenter = presenter {
            presenter.presentSlideMenu()
        }
    }
    
    @objc func destinationWrapperView_Tap() {
        navigateChooseAddress()
    }
    
    func createMapView() {
        var currentLocationLat: Double = 10.8231
        var currentLocationLong: Double = 106.6297
       
        if let currentLocation = jetLocationmanager.currentLocation {
            currentLocationLat = currentLocation.coordinate.latitude
            currentLocationLong = currentLocation.coordinate.longitude
        }
        
        let camera = GMSCameraPosition.camera(withLatitude: currentLocationLat, longitude: currentLocationLong, zoom: 14)
        mapView = GMSMapView.map(withFrame: CGRect.init(x: 0, y: 0, width: ViewService.screenSize().width, height: ViewService.screenSize().height - 110), camera: camera)
        mapWrapperView.addSubview(mapView)
        mapView.translatesAutoresizingMaskIntoConstraints = false
        let constraints: [NSLayoutConstraint] = [
            NSLayoutConstraint.init(item: mapView!, attribute: .leading, relatedBy: .equal, toItem: mapWrapperView, attribute: .leading, multiplier: 1, constant: 0),
            NSLayoutConstraint.init(item: mapView!, attribute: .trailing, relatedBy: .equal, toItem: mapWrapperView, attribute: .trailing, multiplier: 1, constant: 0),
            NSLayoutConstraint.init(item: mapView!, attribute: .top, relatedBy: .equal, toItem: mapWrapperView, attribute: .top, multiplier: 1, constant: 0),
            NSLayoutConstraint.init(item: mapView!, attribute: .bottom, relatedBy: .equal, toItem: mapWrapperView, attribute: .bottom, multiplier: 1, constant: 0)]
        mapWrapperView.addConstraints(constraints)
        mapView.delegate = self
        let position = CLLocationCoordinate2DMake(currentLocationLat, currentLocationLong)
        sourceMarker = GMSMarker.init()
        sourceMarker.icon = UIImage.init(assetId: .current_location_icon)
        sourceMarker.map = mapView
        sourceMarker.position = position
        
    }
}

// MARK: - JETLocationManagerDelegate
extension SearchAddressViewController: JETLocationManagerDelegate {
    func locationManagerCannotFetchCurrentLocation() {
        
    }
    
    func locationManagerDidFetchCurrentLocation(_ location: CLLocation) {
        if let presenter = presenter {
            if let currentLocation = JETLocationManager.sharedInstance.currentLocation {
                presenter.lookUpAddress(location: currentLocation)
                mapView.camera = GMSCameraPosition(target: currentLocation.coordinate, zoom: 16, bearing: 0, viewingAngle: 0)
            }
        }
    }
}

// MARK: - SearchAddressViewProtocol
extension SearchAddressViewController: SearchAddressViewProtocol {
    func didGetDirectionSuccess() {
        
    }
    
    func didGetDirectionFail() {
        
    }
    
    func didLookUpAddressSuccess(info: GoogleGeocode, for coordinate: CLLocationCoordinate2D) {
        self.infoGeoCode = info
        print(info.formattedAddress)
        startAddressLb.text = info.formattedAddress
        
    }
    
    func didLookUpAddressFail() {
        
    }
}

// MARK: - GMSMapViewDelegate
extension SearchAddressViewController: GMSMapViewDelegate {
    func mapView(_ mapView: GMSMapView, idleAt position: GMSCameraPosition) {
//        reverseGeocodeCoordinate(position.target)
    }
    
    func mapView(_ mapView: GMSMapView, willMove gesture: Bool) {
    
    }
}

// MARK: - Extension: UITextFieldDelegate
extension SearchAddressViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        return true
    }
}
