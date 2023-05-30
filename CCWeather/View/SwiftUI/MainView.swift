//
//  RootView.swift
//  CCWeather
//
//  Created by Tarannum Kadri on 30/05/23.
//  Copyright © 2021 . All rights reserved.
//

import SwiftUI

struct MainView: View {
    
    @ObservedObject var locationHandler: LocationViewModal
    
    var body: some View {
        Group {
            if locationHandler.isLoading {
                ProgressView("Loading...")
                    .padding()
            } else {
                if locationHandler.isPermissionGranted() {
                    WeatherSearch(locationHandler: locationHandler)
                } else {
                    LocationServiceDenied()
                }
            }
        }
        .onAppear() {
            locationHandler.requestWhenInUseAuthorization()
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView(locationHandler: LocationViewModal())
    }
}
