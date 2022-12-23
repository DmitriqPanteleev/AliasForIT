//
//  UserStorage.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 15.11.2022.
//

import Foundation

final class UserStorage {
    
    static let shared = UserStorage()
    
    private let defaults = UserDefaults.standard
    
    // MARK: - System
    var alreadyLaunched: Bool {
        get {
            defaults.bool(forKey: Consts.SettingsKeys.alreadyLaunched)
        }
        set {
            defaults.set(newValue, forKey: Consts.SettingsKeys.alreadyLaunched)
        }
    }
    
    // MARK: - Personal
    let defaultAvatars: [String] = ["elon", "facebook", "silicon", "mrrobot", "profsoft"]
    
    // MARK: - Settings
    var pointsForWin: Int {
        get {
            defaults.integer(forKey: Consts.SettingsKeys.pointsForWin)
        }
        set {
            defaults.set(newValue, forKey: Consts.SettingsKeys.pointsForWin)
        }
    }
    
    var roundTime: Int {
        get {
            defaults.integer(forKey: Consts.SettingsKeys.roundTime)
        }
        set {
            defaults.set(newValue, forKey: Consts.SettingsKeys.roundTime)
        }
    }
    
    var isSoundActive: Bool {
        get {
            defaults.bool(forKey: Consts.SettingsKeys.isSoundActive)
        }
        set {
            defaults.set(newValue, forKey: Consts.SettingsKeys.isSoundActive)
        }
    }
    
    var isCommonLastWord: Bool {
        get {
            defaults.bool(forKey: Consts.SettingsKeys.isCommonLastWord)
        }
        set {
            defaults.set(newValue, forKey: Consts.SettingsKeys.isCommonLastWord)
        }
    }
    
    private init() {}
}
