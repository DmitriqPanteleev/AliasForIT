//
//  Colors.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 04.12.2022.
//

import SwiftUI
import UIKit

extension Color {
    enum Name: String {
        case appBackground
        case appCard
        case appOrange
        case appYellow
        case appRed
    }
}

extension Color.Name {
    var path: String { "\(rawValue)" }
}

extension Color {
    init(_ name: Color.Name) {
        self.init(name.path)
    }

    static let appBackground = Color(.appBackground)
    static let appCard = Color(.appCard)
    static let appOrange = Color(.appOrange)
    static let appYellow = Color(.appYellow)
    static let appRed = Color(.appRed)
}

extension UIColor {
    convenience init(named name: Color.Name) {
        self.init(named: name.path)!
    }
}
