//
//  PlayButtonView.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 08.12.2022.
//

import SwiftUI

struct PlayButtonView: View {
    
    let style: PlayButtonStyle
    let action: () -> Void
    
    var body: some View {
        HStack {
            Text(style.title)
                .titleThreeWhite(style.titleColor)
        }
        .frame(height: 56)
        .frame(maxWidth: UIScreen.main.bounds.width)
        .background(style.background)
        .cornerRadius(100)
        .onTapGesture(perform: action)
    }
}

struct PlayButtonView_Previews: PreviewProvider {
    static var previews: some View {
        PlayButtonView(style: .next ,action: {})
            .padding(.horizontal)
    }
}
