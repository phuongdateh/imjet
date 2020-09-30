//
//  LocationManager.swift
//  imjet-ios
//
//  Created by DoanDuyPhuong on 9/4/19.
//  Copyright © 2019 DoanDuyPhuong. All rights reserved.
//

import Foundation
import CoreLocation
import UIKit

protocol JETLocationManagerDelegate: class {
    func locationManagerDidFetchCurrentLocation(_ location: CLLocation)
    func locationManagerCannotFetchCurrentLocation()
}

class JETLocationManager: NSObject {
    
    static let sharedInstance: JETLocationManager =  {
        var manager = JETLocationManager()
        manager.locationManager.delegate = manager
        return manager
    }()
    
    var currentLocation: CLLocation? {
        if let currentLocation = UserDefaults.standard.object(forKey: Constants.kCurrentLocation) as? [String: NSNumber] {
            if let lat = currentLocation["lat"], let lng = currentLocation["lng"] {
                return CLLocation.init(latitude: CLLocationDegrees(truncating: lat), longitude: CLLocationDegrees(truncating: lng))
            }
        }
        return nil
    }
    
    var currentStatus: CLAuthorizationStatus!
    weak var delegate: JETLocationManagerDelegate?
    private var locationManager: CLLocationManager
    private var countFeth: Int = 0
    
    override init() {
        self.locationManager = CLLocationManager()
        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
        self.locationManager.requestWhenInUseAuthorization()
    }
    
    func setDelegate() {
        locationManager.delegate = self
    }
    
    func startGettingLocation(isForced: Bool = false) {
        if CLLocationManager.locationServicesEnabled() {
            switch CLLocationManager.authorizationStatus() {
            case .authorizedWhenInUse:
                locationManager.startUpdatingLocation()
            case .denied, .restricted:
                if isForced == true {
                    //forced
                    if let url = URL.init(string: UIApplicationOpenSettingsURLString) {
                        UIApplication.shared.openURL(url)
                    }
                }
                else if let delegate = delegate {
                    delegate.locationManagerCannotFetchCurrentLocation()
                }
            case .notDetermined:
                locationManager.requestWhenInUseAuthorization()
            case .authorizedAlways:
                print("zzzzzzzzz")
            @unknown default:
                break;
            }
        }
        else {
            if isForced == true {
                //forced open location service
                
            }
            else if let delegate = delegate {
                delegate.locationManagerCannotFetchCurrentLocation()
            }
        }
    }
    
    func isEnableLocationService() -> Bool {
        if CLLocationManager.locationServicesEnabled() {
            if CLLocationManager.authorizationStatus() == .denied || CLLocationManager.authorizationStatus() == .notDetermined {
                return false
            }
        }
        return true
    }
}

extension JETLocationManager: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if locations.count > 0 {
            countFeth += 1
            print("CLLocation \(countFeth): \(locations)")
            locationManager.stopUpdatingLocation()
            let location = locations[0]
            let lat = location.coordinate.latitude
            let lng = location.coordinate.longitude
            let currentLocationInfo: [String: NSNumber] = ["lat": lat as NSNumber, "lng": lng as NSNumber]
            UserDefaults.standard.setValue(currentLocationInfo, forKey: Constants.kCurrentLocation)
            if let delegate = delegate {
                delegate.locationManagerDidFetchCurrentLocation(location)
            }
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        if CLLocationManager.authorizationStatus() == .authorizedWhenInUse || CLLocationManager.authorizationStatus() == .authorizedAlways {
//            print("didChangeAuthorization:\(locationManager.location)")
//        }
    }
}
