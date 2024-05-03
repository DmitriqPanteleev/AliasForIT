//
//  PlayCardView.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 29.04.2024.
//

import SwiftUI

struct PlayCardView: View {
    
    @Environment(\.screenSize) private var screenSize
    
    let state: PlayCardState
    let word: String
    let isFirst: Bool
    
    private var cardWidth: CGFloat {
        screenSize.width * 0.715
    }
    
    private var cardHeight: CGFloat {
        screenSize.height * 0.5
    }
    
    var body: some View {
        RoundedRectangle(cornerRadius: 32)
            .stroke(state.borderColor, lineWidth: 2)
            .background(state.backgroundColor)
            .frame(width: cardWidth, height: cardHeight)
            .cornerRadius(32)
            .overlay(alignment: .center) {
                Text(word)
                    .playCard(.appDarkBlue)
                    .multilineTextAlignment(.center)
                    .opacity(isFirst ? 1 : 0.0001)
                    .padding(.horizontal, 4)
            }
    }
}

#Preview {
    PlayCardView(state: .neutral, word: "", isFirst: true)
}
