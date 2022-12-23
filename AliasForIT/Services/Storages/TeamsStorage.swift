//
//  TeamsStorage.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 22.12.2022.
//

import Foundation

struct TeamsStorage {
    // Пиздец какой огромный костыль
    static var shared = TeamsStorage()
    
    private init() {
        self.teams = [.defaultTeam1(), .defaultTeam2()]
    }
    
    var teams: [TeamModel]
}
