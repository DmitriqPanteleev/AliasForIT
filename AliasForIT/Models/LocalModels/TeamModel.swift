//
//  TeamModel.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 15.11.2022.
//

import Foundation

struct TeamModel: Equatable {
    let name: String
    let image: String
    let score: Int
    
    var imageSource: URL? {
        guard let source = URL(string: image) else { return nil }
        return source
    }
}
