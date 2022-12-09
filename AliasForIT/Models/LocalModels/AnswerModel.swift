//
//  AnswerModel.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 09.12.2022.
//

import Foundation

struct AnswerModel: Hashable, Identifiable {
    var id: Int
    let word: String
    var isAnswered: Bool
    
    init(word: String, isAnswered: Bool) {
        self.id = UUID().hashValue
        self.word = word
        self.isAnswered = isAnswered
    }
}
