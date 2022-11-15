//
//  SettingCellStyle.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 15.11.2022.
//

import Foundation

enum SettingsCellStyle {
    case points
    case time
    case audio
    case lastWord
}

extension SettingsCellStyle {
    
    var icon: String {
        switch self {
        case .points:
            return "flag.checkered"
        case .time:
            return "clock"
        case .audio:
            return "headphones"
        case .lastWord:
            return "personalhotspot"
        }
    }
    
    var title: String {
        switch self {
        case .points:
            return "Очки для победы"
        case .time:
            return "Время до конца раунда"
        case .audio:
            return "Звуковые эффекты"
        case .lastWord:
            return "Последнее общее слово"
        }
    }
}
