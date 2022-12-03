//
//  AppDelegate.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 15.11.2022.
//

import UIKit

class AppDelegate: NSObject, UIApplicationDelegate { func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    
    let settings = SettingsManager()
    settings.bindSettings()
    
    return true
  }
}
