//
//  Consts.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 15.11.2022.
//

import Foundation
import UIKit

struct Consts {
    
    enum SettingsKeys {
        static let alreadyLaunched = "alreadyLaunched"
        static let isGameStarted = "isGameStarted"
        
        static let teams = "teams"
        
        static let pointsForWin = "pointsForWin"
        static let roundTime = "roundTime"
        static let isSoundActive = "isSoundActive"
        static let isCommonLastWord = "isCommonLastWord"
        static let isForfeitForMiss = "isForfeitForMiss"
    }
    
    enum SharedLayout {
        static let cardWidth = UIScreen.main.bounds.width * 0.6
        static let cardHeight = UIScreen.main.bounds.height * 0.5
    }
}
