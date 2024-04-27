//
//  RoundModel.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 15.11.2022.
//

import Foundation
import Combine

struct RoundModel: Equatable {
    let team: TeamModel
    let words: [String]
    
    var roundDuration: Int
}
