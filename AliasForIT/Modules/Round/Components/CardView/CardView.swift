//
//  CardView.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 01.12.2022.
//

import SwiftUI

struct CardView: View {
    
    @Binding var backgroundColor: Color
    var word: String
    
    var body: some View {
        ZStack {
            background
            title
        }
    }
}

private extension CardView {
    var background: some View {
        Rectangle()
        .frame(width: Consts.SharedLayout.cardWidth, height: Consts.SharedLayout.cardHeight)
        .addBorder(.yellow, width: 2 ,cornerRadius: 10)
        .foregroundColor(backgroundColor)
    }
    
    var title: some View {
        Text(word)
            .foregroundColor(.white)
            .frame(width: Consts.SharedLayout.cardWidth,
                   height: Consts.SharedLayout.cardHeight,
                   alignment: .center)
    }
}

//struct CardView_Previews: PreviewProvider {
//    static var previews: some View {
//        CardView()
//    }
//}
