//
//  TeamScoreCell.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 06.11.2023.
//

import SwiftUI

struct TeamScoreCell: View {
    
    let model: TeamModel
    let isCurrent: Bool
    
    var body: some View {
        HStack(spacing: 24) {
            GameTeamCell(model: model, isCurrent: isCurrent)
            Text(model.name)
                .teamTitle(isCurrentTeam: isCurrent)
            Spacer()
            ScoreView(score: model.score, style: .normal, isCurrent: isCurrent)
        }
        .padding(.horizontal)
    }
}

struct TeamScoreCell_Previews: PreviewProvider {
    static var previews: some View { 
        TeamScoreCell(model: .defaultTeam1(),
                      isCurrent: true)
        
    }
}
