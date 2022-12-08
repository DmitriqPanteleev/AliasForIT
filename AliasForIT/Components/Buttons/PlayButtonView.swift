//
//  PlayButtonView.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 08.12.2022.
//

import SwiftUI

struct PlayButtonView: View {
    
    let action: () -> Void
    
    var body: some View {
        HStack {
            Text("Играть")
                .titleThreeWhite()
        }
        .onTapGesture {
            action()
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
    }
}

struct PlayButtonView_Previews: PreviewProvider {
    static var previews: some View {
        PlayButtonView(action: {})
            .padding(.horizontal)
    }
}
