//
//  LocationServiceDenied.swift
//  CCWeather
//
//  Created by Tarannum Kadri on 30/05/23.
//  Copyright © 2021 . All rights reserved.
//

import Foundation
import SwiftUI

struct LocationServiceDenied: View {
    
    /// Open settings app to update the permissions
    func openLocationSettings() {
        if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
            if UIApplication.shared.canOpenURL(settingsURL) {
                UIApplication.shared.open(settingsURL)
            }
        }
    }
    
    var body: some View {
      
        VStack {
            Text("Your location service is Disabled!! Please click on Settings -> Select Location Services -> Turn on Location Services")
                .padding()
                .multilineTextAlignment(TextAlignment.center)
                .font(.system(size: 20, weight: .bold))
                        
            Button(action: {
                openLocationSettings()
            }) {
                Text("Settings")
                    .foregroundColor(.white)
                    .padding()
                    .background(Color.blue)
                    .cornerRadius(10)
            }
        }
    }
}

struct LocationServiceDenied_Previews: PreviewProvider {
    
    static var previews: some View {
        LocationServiceDenied()
    }
}
