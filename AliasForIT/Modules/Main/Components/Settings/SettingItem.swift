//
//  SettingItem.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 22.10.2023.
//

import Foundation

enum SettingItem: CaseIterable {
    case timeInterval
    case wordsForWin
    case mode
    case wordsPacks
}

extension SettingItem {
    
    var title: String {
        switch self {
        case .timeInterval:
            return "Время раунда"
        case .wordsForWin:
            return "Слов до победы"
        case .mode:
            return "Уровень сложности"
        case .wordsPacks:
            return "Наборы слов"
        }
    }
    
    var image: SystemImage {
        switch self {
        case .timeInterval:
            return .timeInterval
        case .wordsForWin:
            return .wordsForWin
        case .mode:
            return .levelMode
        case .wordsPacks:
            return .packs
        }
    }
}
