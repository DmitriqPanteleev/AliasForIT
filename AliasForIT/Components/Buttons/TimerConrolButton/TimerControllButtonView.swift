//
//  TimerControlButtonView.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 02.12.2022.
//

import SwiftUI
import Combine

struct TimerControlButtonView: View {
    
    let style: TimerControllButtonStyle
    let callback: () -> Void
    
    var body: some View {
        
        HStack{
            Image(systemName: style.icon)
                .resizable()
                .scaledToFill()
                .foregroundColor(.white)
                .padding(12)
                
        }
        .background(Color.orange)
        .frame(width: Consts.SharedLayout.cardWidth / 7, height: Consts.SharedLayout.cardWidth / 7)
        .cornerRadius(Consts.SharedLayout.cardWidth / 14)
        .onTapGesture(perform: callback)
    }
}

//struct TimerControlButtonView_Previews: PreviewProvider {
//    static var previews: some View {
//        TimerControlButtonView()
//    }
//}
