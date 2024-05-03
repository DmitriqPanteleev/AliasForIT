//
//  PlayCardState.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 29.04.2024.
//

import SwiftUI

enum PlayCardState: String {
    case neutral
    case missed
    case guessed
}

extension PlayCardState {
    var backgroundColor: Color {
        Color(rawValue + "Card")
    }
    
    var borderColor: Color {
        Color(rawValue + "CardWord")
    }
}

