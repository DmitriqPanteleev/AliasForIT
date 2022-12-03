//
//  TimerControllButtonStyle.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 02.12.2022.
//

import Foundation

enum TimerControllButtonStyle {
    case pause
    case resume
}

extension TimerControllButtonStyle {
    
    var icon: String {
        switch self {
        case .pause:
            return "pause.fill"
        case .resume:
            return "play.fill"
        }
    }
}
