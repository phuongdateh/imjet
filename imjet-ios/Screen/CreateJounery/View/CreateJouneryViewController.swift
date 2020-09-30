//
//  CreateJouneryViewController.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 10/20/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import UIKit
import GoogleMaps

class CreateJouneryViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var sourceAddressTf: UITextField!
    @IBOutlet weak var destinationAddressTf: UITextField!
    
    @IBOutlet weak var mapWrapperView: UIView!
    
    @IBOutlet weak var createNowWrapperView: UIView!
    @IBOutlet weak var createPlanWrapperView: UIView!

    // MARK: - Properties
    var presenter: CreateJouneryPresenterProtocol?
    var builder: JourneyRequestBuilder!
    var info: QueryGoogleModel!
    private var direction: GoogleDirection?
    private var mapView: GMSMapView!
    private var path: GMSPath!
    private var routeLine: GMSPolyline = GMSPolyline.init()
    private var sourceMarker: GMSMarker!
    private var destinationMarker: GMSMarker!
    var extraInfo: [String: AnyObject] = [:]
    
    // MARK: - Metadata
    class func storyBoardId() -> String {
        return "CreateJouneryViewController"
    }
    
    class func storyBoardName() -> String {
        return "CreateJounery"
    }
    
    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupTapGesture()
        setupData()
    }
    
    // MARK: - Method
    func setupUI() {
        if let source = extraInfo[Constants.sourceAddress] as? String, let destination = extraInfo[Constants.destinationAddress] as? String {
            info = QueryGoogleModel.init(origin: source, destination)
            sourceAddressTf.text = source
            destinationAddressTf.text = destination
        }
        initMapView()
        initMarker()
        initPolyline()
        
    }
    
    func setupTapGesture() {
        createNowWrapperView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(createNowWrapperView_Tap)))
        createPlanWrapperView.addGestureRecognizer(UITapGestureRecognizer.init(target: self, action: #selector(createPlanWrapperView_Tap)))
    }
    
    func setupData() {
        if let presenter = presenter {
            presenter.getDirection(info)
        }

    }
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        
        
    }
    
    func initPolyline() {
        routeLine.strokeColor = UIColor.black
        routeLine.strokeWidth = 5
    }
    
    func initMarker() {
        if sourceMarker == nil {
            sourceMarker = GMSMarker.init()
            sourceMarker.icon = UIImage.init(assetId: .current_location_icon)
        }
        if destinationMarker == nil {
            destinationMarker = GMSMarker.init()
            destinationMarker.icon = UIImage.init(assetId: .destination_icon)
        }
    }
    
    func updatePositionSourceMarker(_ startLocation: GoogleDirectionLegLocation) {
        sourceMarker.map = mapView
        sourceMarker.position = CLLocationCoordinate2D.init(latitude: startLocation.lat, longitude: startLocation.lng)
    }
    
    func updatePositionDestinationMarker(_ endLocation: GoogleDirectionLegLocation) {
        destinationMarker.map = mapView
        destinationMarker.position = CLLocationCoordinate2D.init(latitude: endLocation.lat, longitude: endLocation.lng)
    }
    
    func updatePolyline() {
        if let direction = direction {
            let route = direction.routes[0]
            if let polyline = route.overviewPolyline, let path = GMSPath.init(fromEncodedPath: polyline.points) {
                routeLine.path = path
                routeLine.map = mapView
            }
            else {
                routeLine.path = nil
                routeLine.map = nil
            }
        }
    }
    
    func initMapView() {
        var currentLocationLat: Double = 10.8231
        var currentLocationLng: Double = 106.6297
        let currentLocation = JETLocationManager.sharedInstance.currentLocation
        if let currentLocation = currentLocation {
            currentLocationLat = currentLocation.coordinate.latitude
            currentLocationLng = currentLocation.coordinate.longitude
        }
        let camera = GMSCameraPosition.camera(withLatitude: currentLocationLat, longitude: currentLocationLng, zoom: 20)
        mapView = GMSMapView.map(withFrame: CGRect.init(x: 0, y: 0, width: ViewService.screenSize().width, height: ViewService.screenSize().height - 150), camera: camera)
        mapWrapperView.addChildView(mapView)
        mapView.delegate = self
    }
    
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
    

    // MARK: - WrapperViewDidTap
    @objc func createNowWrapperView_Tap() {
        let date = NSDate()
        print("Now date: \(date)")
        builder.departureTime = Int(date.timeIntervalSince1970)
        setPhoneBuilder()
        builder.isPlan = false
        if let direction = direction {
            builder.directionRequestID = direction.directionRequestId
        }
        if let presenter = presenter {
            presenter.pushSearchJourney(builder, extraInfo)
        }
    }
    
    @objc func createPlanWrapperView_Tap() {
        builder.isPlan = true
        setPhoneBuilder()
        if let direction = direction {
            builder.directionRequestID = direction.directionRequestId
        }
        if let presenter = presenter {
            presenter.pushPickUpTime(builder, extraInfo)
        }
    }
    
}

// MARK: - CreateJouneryViewProtocol
extension CreateJouneryViewController: CreateJouneryViewProtocol {
    func didGetDirectionSuccess(_ infoDirection: GoogleDirection) {
        self.direction = infoDirection
        if let direction = direction {
            var distance: Int = 0
            var overviewPolylineStr: String = ""
            let routes = direction.routes
            if routes.count > 0 {
                let firstRoute = routes[0]
                for leg in firstRoute.legs {
                    distance += leg.distance.value
                }
                if let overviewPolyline = firstRoute.overviewPolyline {
                    overviewPolylineStr = overviewPolyline.points
                }
                let firstLeg = firstRoute.legs[0]
                if let startLocation = firstLeg.startLocation, let endLocation = firstLeg.endLocation {
                    mapView.clear()
                    updatePositionSourceMarker(startLocation)
                    updatePositionDestinationMarker(endLocation)
                    extraInfo.updateValue(startLocation as AnyObject, forKey: "startLocation")
                    extraInfo.updateValue(endLocation as AnyObject, forKey: "endLocation")
                }
            }
            extraInfo.updateValue(overviewPolylineStr as AnyObject, forKey: "overviewPolyline")
            extraInfo.updateValue(distance as AnyObject, forKey: "distance")
        }
        updatePolyline()
    }
    
    func didGetDirectionFail() {
        
    }
}

// MARK: - GMSMapViewDelegate
extension CreateJouneryViewController: GMSMapViewDelegate {
    
}
