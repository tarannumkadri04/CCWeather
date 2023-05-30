//
//  WeatherServiceProtocol.swift
//  CCWeather
//
//  Created by Tarannum Kadri on 23/01/02.
//  Copyright © 2021 . All rights reserved.
//

import Foundation

/// Declare loosely dependent functions for WeatherService
protocol WeatherServiceProtocol {
    
    func fetchWeather(withQuery q: String, completion: @escaping (Result<WeatherModal?, APIError>) -> Void)
    func fetchWeather(withLatitute lat: Double, longitude lon: Double, completion: @escaping (Result<WeatherModal?, APIError>) -> Void)
}
