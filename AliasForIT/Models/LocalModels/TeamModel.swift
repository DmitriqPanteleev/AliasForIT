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
    var image: String
    var score: Int
    
    init(name: String, image: String) {
        self.id = UUID().hashValue
        self.name = name
        self.image = image
        self.score = 0
    }
    
    init(id: Int, name: String, image: String, score: Int) {
        self.id = id
        self.name = name
        self.image = image
        self.score = score
    }
    
    var imageSource: URL? {
        // add placeholder
        guard let source = URL(string: image) else { return nil }
        return source
    }
    
    // MARK: - Mock teams
    static func defaultTeam1() -> TeamModel {
        TeamModel(name: "Константы",
                  image: "const")
    }
    
    static func defaultTeam2() -> TeamModel {
        TeamModel(name: "Ворота",
                  image: "gates")
    }
    
    static func emptyTeam() -> TeamModel {
        TeamModel(name: "Название команды", image: "")
    }
}
