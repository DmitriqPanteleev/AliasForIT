//
//  GameConfigurable.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 21.04.2024.
//

import Foundation

protocol GameConfigurable {
    var roundTime: Int { get }
    var pointsForWin: Int { get }
    
    func updateTime(_ option: SettingUpdateOption)
    func updatePoints(_ option: SettingUpdateOption)
}
