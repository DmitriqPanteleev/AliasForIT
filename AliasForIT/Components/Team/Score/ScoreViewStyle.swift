//
//  ScoreViewStyle.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 06.11.2023.
//

import Foundation

enum ScoreViewStyle {
    case big
    case normal
    case expanded
}

extension ScoreViewStyle {
    var width: CGFloat {
        switch self {
        case .big:
            return 64
        case .normal:
            return 32
        case .expanded:
            return 72
        }
    }
    
    var height: CGFloat {
        switch self {
        case .big:
            return 64
        case .normal:
            return 32
        case .expanded:
            return 44
        }
    }
    
    var cornerRadius: CGFloat {
        self == .expanded ? 32 : self.width
    }
}
