//
//  TeamControlable.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 21.04.2024.
//

import Foundation

protocol TeamControlable {
    
    var teams: [TeamModel] { get }
    
    func appendTeam(_ team: TeamModel)
    func deleteTeam(by id: Identifier)
}
