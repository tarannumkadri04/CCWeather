//
//  WeatherViewModal.swift
//  CCWeather
//
//  Created by Tarannum Kadri on 23/01/02.
//  Copyright © 2021 . All rights reserved.
//

import Foundation
import SwiftUI

class WeatherViewModal: ObservableObject {
    
    private let weatherService: WeatherServiceProtocol
    
    @Published var isRequesting: Bool = true
    @Published var weather: WeatherModal?
    @Published var error: Error?
    
    var onWeatherUpdate: (() -> Void)?
    
    //------------------------------------------------------
    
    //MARK: Fetch
    
    /// To fetch weather information with respect to entered search characers
    /// - Parameter q: search string
    func fetchWeather(withQuery q: String) {
        
        isRequesting = true
        weatherService.fetchWeather(withQuery: q) { [weak self] result in
           
            guard let self = self else { return }
            
            self.isRequesting = false

            switch result {
            case .success(let weather):                
                self.weather = weather                
                self.objectWillChange.send()
            case .failure(let error):
                debugPrint(error)
                self.error = error
                self.objectWillChange.send()
            }
        }
    }
    
    /// To fetch weather information with location coordinates
    /// - Parameters:
    ///   - lat: Geolocatino latitude
    ///   - lon: Geolocation longitude
    func fetchWeather(withLatitude lat: Double, longitude lon: Double) {
        
        isRequesting = true
        weatherService.fetchWeather(withLatitute: lat, longitude: lon) { [weak self] result in
            
            guard let self = self else { return }
            
            self.isRequesting = false

            switch result {
            case .success(let weather):
                self.weather = weather
                self.objectWillChange.send()
            case .failure(let error):
                debugPrint(error)
                self.error = error
                self.objectWillChange.send()
            }
        }
    }
    
    //------------------------------------------------------
    
    //MARK: Init
    
    /// Initilised WeatherService
    /// - Parameter weatherService: class which implement WeatherServiceProtocol
    init(weatherService: WeatherServiceProtocol = WeatherService()) {
        self.weatherService = weatherService
    }
      
    //------------------------------------------------------
}

