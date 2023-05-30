//
//  LocationViewModal.swift
//  CCWeather
//
//  Created by Tarannum Kadri on 23/01/02.
//  Copyright © 2021 . All rights reserved.
//

import Foundation
import SwiftUI

/// LocationViewModal is the class which mainly manage the Location related View and Location Service
class LocationViewModal: ObservableObject {
    
    private let locationService: LocationServiceProtocol
    
    var onLocationUpdate: (() -> Void)?
    
    @Published var isLoading: Bool = true
    @Published var isAuthorizedStatusUpdate: Bool = false
    @Published var locationModal: LocationModal?
    
    var isLocationDidUpdate: Bool = false
    
    //------------------------------------------------------
    
    //MARK: Request
    
    /// To request while in use application location service
    func requestWhenInUseAuthorization() {
        return locationService.requestWhenInUseAuthorization()
    }
    
    /// /// To check is always or while in use permission been grantted.
    /// - Returns: True if it is grantted else false
    func isPermissionGranted() -> Bool {
        return locationService.isPermissionGranted()
    }
    
    //------------------------------------------------------
    
    //MARK: Init
    
    /// Initilised LocationService
    /// - Parameter locationService: class which implement LocationServiceProtocol
    init(locationService: LocationServiceProtocol = LocationService()) {        
        
        self.locationService = locationService
        
        self.locationService.onAuthorizeUpdate {
            self.isLoading = false
            self.isAuthorizedStatusUpdate = true
        }
        
        self.locationService.onLocationUpdate { lat, lon in
            self.locationModal = LocationModal(lon: lon , lat: lat)
            self.isLoading = false
            self.isLocationDidUpdate = true
            //self.objectWillChange.send()
            self.onLocationUpdate?()
        }
    }
    
    //------------------------------------------------------
}
