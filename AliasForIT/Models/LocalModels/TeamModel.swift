//
//  TeamModel.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 15.11.2022.
//

import Foundation

struct TeamModel: Equatable {
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
        guard let source = URL(string: image) else { return nil }
        return source
    }
    
    static func defaultTeam1() -> TeamModel {
        TeamModel(name: "Константы",
                  image: "https://yt3.ggpht.com/ytc/AMLnZu9CTrwR1EFNZuEqb9TNFEAqBNMyFz1ylQNBNRVgwQ=s900-c-k-c0x00ffffff-no-rj")
    }
    
    static func defaultTeam2() -> TeamModel {
        TeamModel(name: "Умер в конце драйва",
                  image: "https://i.pinimg.com/originals/56/6c/aa/566caa613d4c3ea046f1db3b30487e41.jpg")
    }
}
