//
//  PlayButtonStyle.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 09.12.2022.
//

import SwiftUI

// TODO: сделать цвета для разных кейсов
enum PlayButtonStyle {
    case play
    case next
    case stop
}

extension PlayButtonStyle {
    
    var title: String {
        switch self {
        case .play:
            return "Играть"
        case .next:
            return "Продолжить"
        case .stop:
            return "Завершить"
        }
    }
    
    var titleColor: Color {
        switch self {
        case .play:
            return .white
        case .next:
            return .white
        case .stop:
            return .appRed
        }
    }
    
    var background: some View {
        switch self {
        case .play:
            return LinearGradient(
                colors:
                    [
                        .appYellow,
                        .appOrange
                    ],
                startPoint: .bottomLeading,
                endPoint: .center)
        case .next:
            return LinearGradient(
                colors:
                    [
                        .appYellow,
                        .appOrange
                    ],
                startPoint: .bottomLeading,
                endPoint: .center)
        case .stop:
            return LinearGradient(colors: [.clear, .clear], startPoint: .center, endPoint: .center)
        }
    }
}
