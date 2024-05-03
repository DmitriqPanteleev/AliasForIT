//
//  ScoreView.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 06.11.2023.
//

import SwiftUI

struct ScoreView: View {
    
    let score: Int
    let style: ScoreViewStyle
    let isCurrent: Bool
    
    var body: some View {
        Text(String(score))
            .scoreTitleStyle(isBig: style != .normal, isCurrent: isCurrent)
            .contentTransition(.numericText())
            .frame(width: style.width, height: style.height)
            .background(Color.appLightGray)
            .cornerRadius(style.cornerRadius)
            .overlay {
                RoundedRectangle(cornerRadius: style.cornerRadius)
                    .stroke(Color.white, lineWidth: 4)
            }
            .animation(.linear, value: score)
    }
}

struct ScoreView_Previews: PreviewProvider {
    static var previews: some View {
        ScoreView(score: 10, style: .big, isCurrent: false)
    }
}
