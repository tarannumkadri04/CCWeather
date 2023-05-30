//
//  AppDelegate.swift
//  NewProject
//
//  Created by Tarannum Kadri on 23/01/02.
//  Copyright © 2021. All rights reserved.
//

import UIKit
import IQKeyboardManagerSwift
import SwiftUI

//@UIApplicationMain - comment @UIApplicationMain to apply SwiftUI
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {
    
    var window: UIWindow?
    
    /// Single instance of shared UIApplication
    static var shared: AppDelegate {
        return UIApplication.shared.delegate as! AppDelegate
    }
    
    //------------------------------------------------------
    
    //MARK: Customs
    
    /// keyboard configutation
    private func configureKeboard() {
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
    }
    
    /// to get custom added font names
    private func getCustomFontDetails() {
        #if DEBUG
        for family in UIFont.familyNames {
            let sName: String = family as String
            debugPrint("family: \(sName)")
            for name in UIFont.fontNames(forFamilyName: sName) {
                debugPrint("name: \(name as String)")
            }
        }
        #endif
    }
    
    /// To register remote notification to get device token
    /// - Parameter application: <#application description#>
    func registerRemoteNotificaton(_ application: UIApplication) {
       
        if #available(iOS 10.0, *) {
            
            UNUserNotificationCenter.current().delegate = self
            
            let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
            UNUserNotificationCenter.current().requestAuthorization(
                options: authOptions,
                completionHandler: {_, _ in })
            
        } else {
            
            let settings: UIUserNotificationSettings =
                UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            application.registerUserNotificationSettings(settings)
        }
        
        application.registerForRemoteNotifications()
    }
    
    //------------------------------------------------------
    
    //MARK: - UNUserNotificationCenterDelegate
    
    /// To get remote notifiaction device token
    /// - Parameters:
    ///   - application: shared UIApplication instance
    ///   - deviceToken: device token in Data form
    func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        
        debugLog(object: deviceToken.hexString)
    }
    
    /// To get information on device token if APNS configuratino failed
    /// - Parameters:
    ///   - application: shared UIApplication instance
    ///   - error: Error instance
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error) {
        debugPrint("didFailToRegisterForRemoteNotificationsWithError: \(error.localizedDescription)")
    }
    
    //------------------------------------------------------
    
    //MARK: UIApplicationDelegate
    
    /// Immediate method call after willFinishLaunchingWithOptions
    /// - Parameters:
    ///   - application: shared UIApplication instance
    ///   - launchOptions: holds additional information
    /// - Returns: true if launch execution successfully
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
         
        configureKeboard()
        getCustomFontDetails()
        window?.tintColor = .black
        
        return true
    }
    
    /// Application supported interface orientation
    /// - Parameters:
    ///   - application: shared UIApplication instance
    ///   - window: shared UIWindow instance
    /// - Returns: instance of UIInterfaceOrientationMask
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return .portrait
    }
    
    //------------------------------------------------------
}

@available(iOS 14.0, *)
@main

/// SwiftUI main WeatherApp class
struct WeatherApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    init() {
        //initilisation if needed
    }
    
    /// main window body prepration with MainView
    var body: some Scene {
        WindowGroup {
            MainView(locationHandler: LocationViewModal())
        }
    }
}

