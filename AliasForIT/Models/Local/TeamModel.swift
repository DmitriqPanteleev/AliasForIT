//
//  TeamModel.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 15.11.2022.
//

import Foundation

struct TeamModel: Equatable, Identifiable {
    let id: Int
    var name: String
    var image: TeamImage
    var score: Int
    
    // MARK: - Initializers
    init(name: String, image: TeamImage) {
        self.id = UUID().hashValue
        self.name = name
        self.image = image
        self.score = 0
    }
    
    init(id: Int, name: String, image: TeamImage, score: Int) {
        self.id = id
        self.name = name
        self.image = image
        self.score = score
    }
    
    
    // MARK: - Mock Teams
    static func defaultTeam1() -> TeamModel {
        TeamModel(name: "Константы", image: .elon)
    }
    
    static func defaultTeam2() -> TeamModel {
        TeamModel(name: "Ворота", image: .facebook)
    }
    
    static func emptyTeam() -> TeamModel {
        TeamModel(name: "Название команды", image: .mrrobot)
    }
}
