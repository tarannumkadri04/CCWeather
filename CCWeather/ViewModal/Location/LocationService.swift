//
//  LocationService.swift
//  CCWeather
//
//  Created by Tarannum Kadri on 23/01/02.
//  Copyright © 2021 . All rights reserved.
//

import Foundation

/// LocationService is the class which implement the LocationServiceProtocol methods for execution
class LocationService: LocationServiceProtocol {
      
    /// /// To check is always or while in use permission been grantted.
    /// - Returns: True if it is grantted else false
    func isPermissionGranted() -> Bool {
        return LocationManager.shared.isPermissionGranted()
    }
    
    /// To request while in use application location service
    func requestWhenInUseAuthorization() {
        LocationManager.shared.requestWhenInUseAuthorization()
        LocationManager.shared.startLocation()
    }
    
    /// On location update execution
    /// - Parameter completion: <#completion description#>
    func onLocationUpdate(completion: @escaping (Double, Double) -> Void) {
        LocationManager.shared.onLocationUpdate = { lat, lon in            
            completion(lat, lon)
        }
    }
    
    /// On Authorisation status changed execution
    func onAuthorizeUpdate(completion: @escaping () -> Void) {
        LocationManager.shared.onAuthorizeUpdate = {
            completion()
        }
    }
}
