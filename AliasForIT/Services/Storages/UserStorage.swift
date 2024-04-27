//
//  UserStorage.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 15.11.2022.
//

import Foundation

final class UserStorage {
    
    static let shared = UserStorage()
    private init() {}
    
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
}
