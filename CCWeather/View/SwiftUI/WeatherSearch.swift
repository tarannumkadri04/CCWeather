//
//  WeatherSearch.swift
//  CCWeather
//
//  Created by Tarannum Kadri on 30/05/23.
//  Copyright © 2021 . All rights reserved.
//

import Foundation
import SwiftUI

struct WeatherSearch: View {
    
    @State var locationHandler: LocationViewModal
    @State var weatherHandler: WeatherViewModal = WeatherViewModal()
        
    @State private var searchText = String()
    
    var body: some View {
        VStack {
            SearchBar(text: $searchText, onSearch: search)
                .padding(.horizontal)
            if let error = weatherHandler.error {
                VStack {
                    Text(error.localizedDescription)
                        .padding()
                        .multilineTextAlignment(TextAlignment.center)
                        .font(.system(size: 20, weight: .bold))
                }
            }
            
            if self.weatherHandler.isRequesting == false, searchText.isEmpty == false, self.weatherHandler.weather?.id == nil {
                WeatherConditionErrorView(message: "city not found")
            } else {
                WeatherConditionView(weatherHandler: self.weatherHandler, locationHandler: self.locationHandler)
            }
            
        }
        .onAppear() {
            locationHandler.onLocationUpdate = {
                if let location = locationHandler.locationModal {
                    let lat = location.lat
                    let lon = location.lon
                    self.weatherHandler.fetchWeather(withLatitude: lat, longitude: lon)
                }
            }
        }        
    }
    
    func search() {
        
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
        
        if searchText.isEmpty == false {
            weatherHandler.fetchWeather(withQuery: searchText)
        }
    }
}

struct SearchBar: View {
    
    @Binding var text: String
    var onSearch: () -> Void
    
    var body: some View {
        HStack {
            TextField("Search", text: $text, onCommit: onSearch)
                .textFieldStyle(RoundedBorderTextFieldStyle())
            
            Button(action: onSearch) {
                Image(systemName: "magnifyingglass")
            }
        }
    }
}

struct WeatherConditionView: View {
    
    @ObservedObject var weatherHandler: WeatherViewModal
    @ObservedObject var locationHandler: LocationViewModal
    
    var body: some View {
        VStack {
            Image(weatherHandler.weather?.weather?.first?.icon ?? String())
                .resizable()
                .frame(width: 200, height: 200)
                .font(.system(size: 100))
            Text(weatherHandler.weather?.weather?.first?.description ?? String())
                .font(.title)
        }
    }
}

struct WeatherConditionErrorView: View {
    
    var message: String
    
    var body: some View {
        VStack {
            Image(String())
                .resizable()
                .frame(width: 200, height: 200)
                .font(.system(size: 100))
            Text(message)
                .font(.title)
                .padding()
        }
    }
}
