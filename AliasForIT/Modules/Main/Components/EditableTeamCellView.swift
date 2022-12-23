//
//  EditableTeamCellView.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 12.12.2022.
//

import SwiftUI
import Kingfisher

struct EditableTeamCellView: View {
    
    let model: TeamModel
    
    let onEdit: () -> Void
    let onDelete: () -> Void
    
    var body: some View {
        HStack(spacing: 10) {
            avatar
                .padding(.leading, 14)
                .padding(.vertical, 14)
            
            Text(model.name)
                .titleThreeWhite()
                .lineLimit(1)
            
            Spacer()
            
            Image(systemName: "slider.horizontal.3")
                .foregroundColor(.white)
                .onTapGesture(perform: onEdit)
            
            Image(systemName: "trash.fill")
                .foregroundColor(.white)
                .padding(.trailing, 14)
                .onTapGesture(perform: onDelete)
        }
        .background(Color.black.opacity(0.1))
        .cornerRadius(10)
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(lineWidth: 2).foregroundColor(.appCard)
            .shadow(radius: 4, x: 0, y: 4)
            .shadow(radius: 2, x: 0, y: 2))
        
    }
}

private extension EditableTeamCellView {
    @ViewBuilder var avatar: some View {
        Image(model.image)
            .resizable()
            .scaledToFill()
            .frame(width: UIScreen.main.bounds.width * (40/375), height: UIScreen.main.bounds.width * (40/375))
            .cornerRadius(80)
            .overlay(RoundedRectangle(cornerRadius: 80).stroke(lineWidth: 1).foregroundColor(.appCard))
    }
}

struct EditableTeamCellView_Previews: PreviewProvider {
    static var previews: some View {
        EditableTeamCellView(model: .defaultTeam2(), onEdit: {}, onDelete: {})
    }
}
