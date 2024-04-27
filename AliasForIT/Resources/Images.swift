//
//  Images.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 21.10.2023.
//

import SwiftUI

enum SystemImage: String {
    case settings = "gearshape.fill"
    case photo
    case checkMark = "checkmark.rectangle.portrait.fill"
    case playFill = "play.fill"
    case addTeam = "plus"
    case removeTeam = "trash.fill"
    case close = "xmark"
    
    // MARK: - Settings
    case timeInterval = "clock.arrow.circlepath"
    case wordsForWin = "list.bullet.circle"
    case levelMode = "chart.bar"
    case packs = "archivebox.circle.fill"
}

enum TeamImage: String, CaseIterable {
    case elon
    case facebook
    case silicon
    case mrrobot
}

extension Image {
    init(_ systemImage: SystemImage) {
        self.init(systemName: systemImage.rawValue)
    }
    
    init(_ teamImage: TeamImage) {
        self.init(teamImage.rawValue)
    }
}
