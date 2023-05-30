//
//  PreferenceManager.swift
//  NewProject
//
//  Created by Tarannum Kadri on 23/01/02.
//  Copyright © 2021. All rights reserved.
//

import UIKit
import AssistantKit

internal class PreferenceManager: NSObject {

    public static var shared = PreferenceManager()
    
    //------------------------------------------------------
    
    //MARK: Settings
    
    /// Define request base URL, Later should to move in Build Settings and fetch from Info Directory  with $(BASE_URL)
    var baseURL: String {
        return "https://api.openweathermap.org/"    
    }
    
    /// Define weather APPID, Later should to move in Build Settings and fetch from Info Directory  with $(WEATHER_APPID)
    var weatherAppId: String {
        return "176b6f6f679d862576711f79f6d09db8"
    }
   
    //------------------------------------------------------
}
