//
//  GameTeamCell.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 06.11.2023.
//

import SwiftUI

struct GameTeamCell: View {
    
    let model: TeamModel
    let isCurrent: Bool
    
    var body: some View {
        Image(model.image)
            .resizable()
            .scaledToFill()
            .frame(width: 84, height: 84)
            .overlay(content: colorOverlay)
            .mask { Circle() }
    }
    
    @ViewBuilder
    private func colorOverlay() -> some View {
        if !isCurrent {
            Color.white.opacity(0.3)
        }
    }
}

struct GameTeamCell_Previews: PreviewProvider {
    static var previews: some View {
        GameTeamCell(model: .defaultTeam1(), isCurrent: false)
    }
}
