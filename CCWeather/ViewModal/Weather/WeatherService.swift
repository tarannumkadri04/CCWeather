//
//  WeatherService.swift
//  CCWeather
//
//  Created by Tarannum Kadri on 23/01/02.
//  Copyright © 2021 . All rights reserved.
//

import Foundation

class WeatherService: WeatherServiceProtocol {
        
    func fetchWeather(withQuery q: String, completion: @escaping (Result<WeatherModal?, APIError>) -> Void) {
        
        let parameter: [String: Any] = [
            Request.Parameter.weatherQ: q,
            Request.Parameter.appid: PreferenceManager.shared.weatherAppId
        ]
        
        RequestManager.shared.requestGET(requestMethod: Request.Method.weather, parameter: parameter, decodingType: WeatherModal.self) { response in
            
            let response = Result<WeatherModal?, APIError>.success(response)
            completion(response)
            
        } failureBlock: { error in
            
            let response = Result<WeatherModal?, APIError>.failure(APIError.invalidData)
            completion(response)
        }
    }
    
    func fetchWeather(withLatitute lat: Double, longitude lon: Double, completion: @escaping (Result<WeatherModal?, APIError>) -> Void) {
        
        let parameter: [String: Any] = [
            Request.Parameter.latitude: lat,
            Request.Parameter.longitude: lon,
            Request.Parameter.appid: PreferenceManager.shared.weatherAppId
        ]
        
        //http://api.openweathermap.org/geo/1.0/reverse?lat=51.5098&lon=-0.1180&appid=176b6f6f679d862576711f79f6d09db8
        
        RequestManager.shared.requestGET(requestMethod: Request.Method.reverseGeocode, parameter: parameter, decodingType: [GeoCodeModal].self) { response in
            
            if let firstObj = response.first {
            
                var query: [String] = []
                if let city = firstObj.name {
                    query.append(city)
                }
                if let state = firstObj.state {
                    query.append(state)
                }
                if let country = firstObj.country {
                    query.append(country)
                }
                
                self.fetchWeather(withQuery: query.joined(separator: ","), completion: completion)
            }
            
        } failureBlock: { error in
            
            let response = Result<WeatherModal?, APIError>.failure(APIError.invalidData)
            completion(response)
        }
    }    
}
