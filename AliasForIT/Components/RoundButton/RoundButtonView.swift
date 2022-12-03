//
//  RoundButtonView.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 02.12.2022.
//

import SwiftUI

struct RoundButtonView: View {
    
    let style: RoundButtonStyle
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(systemName: style.image)
        }
        .frame(width: Consts.SharedLayout.cardWidth / 4, height: Consts.SharedLayout.cardWidth / 4)
        .foregroundColor(.black)
        .background(style.color)
        .cornerRadius(50)
        
    }
}

struct RoundButtonView_Previews: PreviewProvider {
    static var previews: some View {
        RoundButtonView(style: .done, action: {})
    }
}
