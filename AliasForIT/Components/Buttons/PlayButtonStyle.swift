//
//  PlayButtonStyle.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 09.12.2022.
//

import Foundation

enum PlayButtonStyle {
    case play
    case next
}

extension PlayButtonStyle {
    
    var title: String {
        switch self {
        case .play:
            return "Играть"
        case .next:
            return "Продолжить"
        }
    }
}
