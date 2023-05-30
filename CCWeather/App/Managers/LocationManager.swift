//
//  LocationManager.swift
//  DynamicForm
//
//  Created by Tarannum Kadri on 29/05/23.
//  Copyright © 2021 . All rights reserved.
//

import Foundation
import CoreLocation

class LocationManager: NSObject, CLLocationManagerDelegate {
    
    /// instance of CLLocationManager
    private let locationManager = CLLocationManager()
    
    /// Update most recent lat and log to the caller
    var onLocationUpdate: ((_ lat: Double, _ lon: Double) -> Void)?
    
    /// Authorize status changed
    var onAuthorizeUpdate: (() -> Void)?
    
    //------------------------------------------------------
    
    //MARK: Shared
    
    /// Single instance of LocationManager
    static let shared = LocationManager()
    
    /// Initialiser
    override init() {
        super.init()
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    //------------------------------------------------------
    
    //MARK: Custom
    
    /// Is permission granted is used to check for device location service permission
    /// - Returns: true if application able to access the device location, false if its failed wither stop device location service or user decline it
    func isPermissionGranted() -> Bool {
        if #available(iOS 14.0, *) {
            return locationManager.authorizationStatus == .authorizedAlways || locationManager.authorizationStatus == .authorizedWhenInUse
        } else {
            return CLLocationManager.authorizationStatus() == .authorizedAlways || CLLocationManager.authorizationStatus() == .authorizedWhenInUse
        }
    }
    
    /// request to while in use location service permission
    func requestWhenInUseAuthorization() {
        locationManager.requestWhenInUseAuthorization()
    }
    
    /// request to provide updated location information to the application
    func startLocation() {
        DispatchQueue.main.async {
            if (CLLocationManager.locationServicesEnabled() && self.isPermissionGranted()) {
                self.locationManager.startUpdatingLocation()
            }
        }
    }
    
    /// request to stop updating the location information to the application
    func stopLocation() {
        self.locationManager.stopUpdatingLocation()
    }
    
    //------------------------------------------------------
    
    //MARK: CLLocationManager Delegate
    
    /// CLLocationManager didUpdateLocations callback method is being called when user move their location towards to the other location
    /// - Parameters:
    ///   - manager: instance of CLLocationManager
    ///   - locations: list of CLLocation
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            onLocationUpdate?(location.coordinate.latitude, location.coordinate.longitude)
        }
    }
    
    /// CLLocationManager locationManagerDidChangeAuthorization status changed
    /// - Parameter manager: <#manager description#>
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        onAuthorizeUpdate?()
    }
        
    //------------------------------------------------------
    
}
