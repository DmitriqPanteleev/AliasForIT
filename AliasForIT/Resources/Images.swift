//
//  Images.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 21.10.2023.
//

import SwiftUI

enum SystemImage: String {
    case settings = "gearshape.fill"
}

enum TeamImage: String {
    case elon = "elon"
    case facebook = "facebook"
    case silicon = "silicon"
    case mrrobot = "mrrobot"
}

extension Image {
    init(_ systemImage: SystemImage) {
        self.init(systemName: systemImage.rawValue)
    }
    
    init(_ systemImage: TeamImage) {
        self.init(systemName: systemImage.rawValue)
    }
}
