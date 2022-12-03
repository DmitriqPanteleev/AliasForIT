//
//  RoundButtonStyle.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 02.12.2022.
//

import Foundation
import SwiftUI

enum RoundButtonStyle {
    case pass
    case done
}

extension RoundButtonStyle {
    
    var image: String {
        switch self {
        case .pass:
            return "xmark"
        case .done:
            return "checkmark"
        }
    }
    
    var color: Color {
        switch self {
        case .pass:
            return Color.red
        case .done:
            return Color.yellow
        }
    }
}
