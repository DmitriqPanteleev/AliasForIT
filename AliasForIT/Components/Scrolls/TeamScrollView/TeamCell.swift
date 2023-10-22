//
//  TeamCell.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 21.10.2023.
//

import SwiftUI

struct TeamCell: View {
    
    let model: TeamModel
    
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
    }
}

struct TeamCell_Previews: PreviewProvider {
    static var previews: some View {
        TeamCell(model: .defaultTeam1())
    }
}
