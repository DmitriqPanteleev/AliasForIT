//
//  SettingsManager.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 15.11.2022.
//

import Foundation

final class SettingsManager {
    private(set) var roundTime = 30
    private(set) var pointsForWin = 50
    private(set) var isSoundActive = true
    private(set) var isCommonLastWord = false
}

extension SettingsManager: GameConfigurable {
    func updateTime(_ option: SettingUpdateOption) {
        switch option {
        case .up:
            guard roundTime < SettingsConfiguration.maxTimeLimit else { return }
            roundTime += SettingsConfiguration.timeStep
        case .down:
            guard roundTime > SettingsConfiguration.minTimeLimit else { return }
            roundTime -= SettingsConfiguration.timeStep
        }
    }
    
    func updatePoints(_ option: SettingUpdateOption) {
        switch option {
        case .up:
            guard pointsForWin < SettingsConfiguration.maxWordsLimit else { return }
            pointsForWin += SettingsConfiguration.wordsStep
        case .down:
            guard pointsForWin > SettingsConfiguration.minWordsLimit else { return }
            pointsForWin -= SettingsConfiguration.wordsStep
        }
    }
}

extension SettingsManager: SettingsEditable {
    func toggleSound() {
        isSoundActive.toggle()
    }
    
    func toggleCommonWord() {
        isCommonLastWord.toggle()
    }
}
