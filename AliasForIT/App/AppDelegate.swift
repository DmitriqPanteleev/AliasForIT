//
//  AppDelegate.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 15.11.2022.
//

import UIKit
import CombineExt
import Combine
import FirebaseCore
import FirebaseDatabase
import FirebaseDatabaseSwift
import FirebaseAnalytics

class AppDelegate: NSObject, UIApplicationDelegate { func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    
    let settings = SettingsManager()
    settings.bindSettings()
    
    FirebaseApp.configure()
    Database.initialize()
    Analytics.logEvent(AnalyticsEventAppOpen, parameters: [:])
    
    
    return true
  }
}
