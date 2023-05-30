//
//  LocationServiceProtocol.swift
//  CCWeather
//
//  Created by Tarannum Kadri on 23/01/02.
//  Copyright © 2021 . All rights reserved.
//

import Foundation

/// Declare loosely dependent functions for LocationService
protocol LocationServiceProtocol {
        
    func requestWhenInUseAuthorization()
    func isPermissionGranted() -> Bool
    func onLocationUpdate(completion: @escaping(_ lat: Double, _ lon: Double) -> Void)
    func onAuthorizeUpdate(completion: @escaping() -> Void)
}
