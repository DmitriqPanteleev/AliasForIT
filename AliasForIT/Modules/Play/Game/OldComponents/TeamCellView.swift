//
//  TeamCellView.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 05.12.2022.
//

import SwiftUI
import Kingfisher

struct TeamCellView: View {
    
    let model: TeamModel
    
    var body: some View {
        HStack(spacing: 10) {
            
            avatar
                .padding(.leading, 14)
                .padding(.vertical, 14)
            
            Text(model.name)
                .titleThreeWhite()
            
            Spacer()
            
            Text(model.score.description)
                .titleThreeYellow()
                .padding(.trailing, 14)
        }
        .background(Color.black.opacity(0.1))
        .cornerRadius(10)
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(.appCard)
            .shadow(radius: 4, x: 0, y: 4)
            .shadow(radius: 2, x: 0, y: 2))
        
    }
}

private extension TeamCellView {
    @ViewBuilder var avatar: some View {
        Image(model.image)
            .resizable()
            .scaledToFill()
            .frame(width: UIScreen.main.bounds.width * (40/375), height: UIScreen.main.bounds.width * (40/375))
            .cornerRadius(80)
            .overlay(RoundedRectangle(cornerRadius: 80).stroke(lineWidth: 1).foregroundColor(.appCard))
    }
}

//struct TeamCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        TeamCellView(model: TeamModel.defaultTeam2())
//    }
//}
