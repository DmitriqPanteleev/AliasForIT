//
//  TeamsStorage.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 22.12.2022.
//

import Foundation

final class TeamStorage {
    
    private(set) var teams: [TeamModel]
    
    init() {
        teams = [.defaultTeam1(), .defaultTeam2()]
    }
}
    
extension TeamStorage: TeamControlable {
    func appendTeam(_ team: TeamModel) {
        teams.append(team)
    }
    
    func deleteTeam(by id: Identifier) {
        teams.removeAll { $0.id == id }
    }
}

extension TeamStorage: TeamEditable {
    func editName(_ name: String, by id: Identifier) {
        let index = teams.firstIndex { $0.id == id } ?? 0
        teams[index].name = name
    }
    
    func editPhoto(_ photo: TeamImage, by id: Identifier) {
        let index = teams.firstIndex { $0.id == id } ?? 0
        teams[index].image = photo
    }
}
