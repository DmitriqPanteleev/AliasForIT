//
//  SharpedCardView.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 04.12.2022.
//

import SwiftUI

struct SharpedCardView<Content: View>: View {
    
    @ViewBuilder var content: Content
    
    var body: some View {
        
        VStack {
            self.content
                .padding(.horizontal, 14)
                .padding(.vertical, 14)
        }
        .background(Color.appBackground.cornerRadius(15)
            .shadow(color: .black.opacity(0.25), radius: 4, x: 0, y: 0))
        .overlay {
            Image("cardBackround")
                .resizable()
                .cornerRadius(15)
                .opacity(0.05)
        }
    }
}

struct SharpedCardView_Previews: PreviewProvider {
    static var previews: some View {
        SharpedCardView {
            TeamCellView(model: TeamModel.defaultTeam2())
        }
        .padding(.horizontal)
        .background(Color.appBackground.ignoresSafeArea())
    }
}
