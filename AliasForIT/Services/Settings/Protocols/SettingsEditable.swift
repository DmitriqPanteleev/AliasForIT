//
//  SettingsEditable.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 21.04.2024.
//

import Foundation

protocol SettingsEditable: GameConfigurable {
    var isSoundActive: Bool { get }
    var isCommonLastWord: Bool { get }
    
    func toggleSound()
    func toggleCommonWord()
}
