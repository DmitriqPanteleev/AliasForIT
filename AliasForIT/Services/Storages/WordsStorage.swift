//
//  WordsStorage.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 16.11.2022.
//

import Foundation

struct WordsStorage {
    static func getRoundWords(count: Int) -> [String] {
        return Words.baseWords.shuffled().suffix(count)
    }
}

