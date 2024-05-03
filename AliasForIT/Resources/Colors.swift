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
        
        // MARK: - New Colors
        case appDarkBlue
        case appGray
        case appDarkGray
        case appLightGray
        
        // MARK: Card colors
        case missedCard
        case neutralCard
        case guessedCard
        case missedCardWord
        case neutralCardWord
        case guessedCardWord
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
    
    // MARK: - New Colors
    static let appDarkBlue = Color(.appDarkBlue)
    static let appGray = Color(.appGray)
    static let appDarkGray = Color(.appDarkGray)
    static let appLightGray = Color(.appLightGray)
    
    static let missedCard = Color(.missedCard)
    static let neutralCard = Color(.neutralCard)
    static let guessedCard = Color(.guessedCard)
    static let missedCardWord = Color(.missedCardWord)
    static let neutralCardWord = Color(.neutralCardWord)
    static let guessedCardWord = Color(.guessedCardWord)
}

extension UIColor {
    convenience init(named name: Color.Name) {
        self.init(named: name.path)!
    }
}
