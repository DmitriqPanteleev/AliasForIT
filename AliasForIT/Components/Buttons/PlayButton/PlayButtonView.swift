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
                .titleThreeWhite()
        }
        .frame(height: 56)
        .frame(maxWidth: UIScreen.main.bounds.width)
        .background(LinearGradient(
            colors:
                [
                    .appYellow,
                    .appOrange
                ],
            startPoint: .bottomLeading,
            endPoint: .center))
        .cornerRadius(100)
        .onTapGesture {
            action()
        }
        .padding(.bottom, 10 + (UIApplication.shared.windows.first?.safeAreaInsets.bottom ?? 0))
    }
}

struct PlayButtonView_Previews: PreviewProvider {
    static var previews: some View {
        PlayButtonView(style: .next ,action: {})
            .padding(.horizontal)
    }
}
