//
//  CustomMapView.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 10/29/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import UIKit
import CoreLocation
import GoogleMaps

protocol CustomMapViewDelegate: class {
    func customMapViewDidFetchCurrentLocation(_ location: CLLocation?)
}

class CustomMapView: View {
    
    //MARK: - Properties
    var mapView: GMSMapView!
    var polyline: GMSPolyline!
    var camera: GMSCameraPosition!
    weak var delegate: CustomMapViewDelegate?
    var locationManager = JETLocationManager.sharedInstance
    var sourceMarker: GMSMarker!
    var destinaitonMarker: GMSMarker!
    
    // MARK: - Init
    
    convenience init(x: CGFloat = 0, y: CGFloat = 0, with: CGFloat = ViewService.screenSize().width, height: CGFloat) {
        self.init(frame: CGRect.init(x: x, y: y, width: with, height: height))
        initCamera()
        initMapView()
        initPolyline()
    }
    
    // MARK: - Lyfe Cycle
    override func awakeFromNib() {
        super.awakeFromNib()
        locationManager.delegate = self
        mapView.isMyLocationEnabled = true
    }
    
    // MARK: - Method
    fileprivate func initMapView() {
        mapView = GMSMapView.map(withFrame: CGRect.init(x: 0, y: 0, width: frame.size.width, height: frame.size.height), camera: camera)
        addChildView(mapView)
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
    }
    
    func updateCamere(_ location: CLLocation?) {
        if let location = location {
            camera = GMSCameraPosition(target: location.coordinate, zoom: 14, bearing: 0, viewingAngle: 0)
        }
    }
    
    fileprivate func initCamera() {
        let currentLocationLat: Double = 10.8231
        let currentLocationLng: Double = 106.6297
        camera = GMSCameraPosition.camera(withLatitude: currentLocationLat, longitude: currentLocationLng, zoom: 14)
    }
    
    fileprivate func initPolyline() {
        polyline = GMSPolyline.init()
        polyline.strokeColor = .black
        polyline.strokeWidth = 5
    }
    
    func updatePolyline(overviewPolyline: String?) {
        if let overviewPolyline = overviewPolyline,
            let path = GMSPath.init(fromEncodedPath: overviewPolyline) {
            polyline.path = path
            polyline.map = mapView
        }
        else {
            polyline.path = nil
            polyline.map = nil
        }
    }
    
    func getCurrentLocation() {
        locationManager.delegate = self
        locationManager.startGettingLocation()
    }
    
    func setPositionSourceMarker(_ startLocation: GoogleDirectionLegLocation) {
        if sourceMarker == nil {
            sourceMarker = GMSMarker.init()
            sourceMarker.icon = UIImage.init(assetId: .current_location_icon)
        }
        sourceMarker.map = mapView
        sourceMarker.position = CLLocationCoordinate2D.init(latitude: startLocation.lat, longitude: startLocation.lng)
    }
    
    func setPositionDestination(_ endLocation: GoogleDirectionLegLocation) {
        if destinaitonMarker == nil {
            destinaitonMarker = GMSMarker.init()
            destinaitonMarker.icon = UIImage.init(assetId: .destination_icon)
        }
        destinaitonMarker.map = mapView
        destinaitonMarker.position = CLLocationCoordinate2D.init(latitude: endLocation.lat, longitude: endLocation.lng)
    }
    
    func cleanAllMaker() {
        mapView.clear()
    }
}

extension CustomMapView: JETLocationManagerDelegate {
    func locationManagerDidFetchCurrentLocation(_ location: CLLocation) {
        if let delegate = delegate {
            delegate.customMapViewDidFetchCurrentLocation(location)
        }
        updateCamere(location)
    }
    
    func locationManagerCannotFetchCurrentLocation() {
        
    }
    
    
}
