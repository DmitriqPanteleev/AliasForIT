//
//  SettingsManager.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 15.11.2022.
//

import Foundation

final class SettingsManager {
    
    private let user = UserStorage.shared
    
    init() {
        bindSettings()
    }
    
    func bindSettings() {
        if !user.alreadyLaunched {
            user.pointsForWin = 30
            user.roundTime = 60
            user.isSoundActive = true
            user.isCommonLastWord = false
        }
    }
}
