//
//  ScreenSize.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 21.04.2024.
//

import SwiftUI

private struct ScreenSize: EnvironmentKey {
    static var defaultValue: CGSize {
        return UIScreen.main.bounds.size
    }
}

extension EnvironmentValues {    
    var screenSize: CGSize {
        self[ScreenSize.self]
    }
}
