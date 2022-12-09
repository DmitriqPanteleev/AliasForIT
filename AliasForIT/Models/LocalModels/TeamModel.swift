//
//  TeamModel.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 15.11.2022.
//

import Foundation

struct TeamModel: Equatable, Identifiable {
    let id: Int
    let name: String
    let image: String
    
    var score: Int
    
    init(name: String, image: String) {
        self.id = UUID().hashValue
        self.name = name
        self.image = image
        self.score = 0
    }
    
    init(name: String, image: String, score: Int) {
        self.id = UUID().hashValue
        self.name = name
        self.image = image
        self.score = score
    }
    
    var imageSource: URL? {
        // add placeholder
        guard let source = URL(string: image) else { return nil }
        return source
    }
    
    static func defaultTeam1() -> TeamModel {
        TeamModel(name: "Константы",
                  image: "https://otvet.imgsmail.ru/download/191308234_8ae84b694b02b5195a81ff67af34a69e_800.gif")
    }
    
    static func defaultTeam2() -> TeamModel {
        TeamModel(name: "Умер в конце драйва",
                  image: "https://i.pinimg.com/originals/56/6c/aa/566caa613d4c3ea046f1db3b30487e41.jpg")
    }
}
