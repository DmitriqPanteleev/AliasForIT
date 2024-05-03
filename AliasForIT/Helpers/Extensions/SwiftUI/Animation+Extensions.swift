//
//  Animation+Extensions.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 29.04.2024.
//

import SwiftUI

// MARK: Animations for cards
extension Animation {
    static let swipeAnimation: Animation = .smooth(duration: 0.5)
    static let returnAnimation: Animation = .interpolatingSpring(mass: 1.0,
                                                                 stiffness: 100,
                                                                 damping: 12,
                                                                 initialVelocity: 0)
}
