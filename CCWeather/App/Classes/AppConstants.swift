//
//  AppConstants.swift
//  NewProject
//
//  Created by Tarannum Kadri on 23/01/02.
//  Copyright © 2021. All rights reserved.
//

import UIKit

let kAppName : String = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ?? String()
let kAppBundleIdentifier : String = Bundle.main.bundleIdentifier ?? String()

let emptyJsonString = "{}"
