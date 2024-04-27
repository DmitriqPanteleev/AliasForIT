//
//  TeamScoreList.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 06.11.2023.
//

import SwiftUI

struct TeamScoreList: View {
    
    let currentTeamId: Int
    let models: [TeamModel]
    
    var body: some View {
        VStack {
            ForEach(models) { model in
                TeamScoreCell(model: model,
                              isCurrent: currentTeamId == model.id)
            }
        }
    }
}

struct TeamScoreList_Previews: PreviewProvider {
    static var previews: some View {
        TeamScoreList(currentTeamId: 0,
                      models: [.defaultTeam1(), .defaultTeam2()])
    }
}
