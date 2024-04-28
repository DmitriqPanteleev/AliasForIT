//
//  SettingItem.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 22.10.2023.
//

import Foundation

enum SettingItem: Equatable {
    case timeInterval(Int)
    case wordsForWin(Int)
    case rules
}

extension SettingItem {
    
    var title: String {
        switch self {
        case .timeInterval:
            return "Время раунда"
        case .wordsForWin:
            return "Слов до победы"
        case .rules:
            return "Правила"
        }
    }
    
    var image: SystemImage {
        switch self {
        case .timeInterval:
            return .timeInterval
        case .wordsForWin:
            return .wordsForWin
        case .rules:
            return .wordsForWin
        }
    }
    
    static func allCases(interval: Int, words: Int) -> [SettingItem] {
        [.timeInterval(interval), .wordsForWin(words)]
    }
}
