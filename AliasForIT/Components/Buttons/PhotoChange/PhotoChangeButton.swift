//
//  PhotoChangeButton.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 05.11.2023.
//

import SwiftUI
import Combine

struct PhotoChangeButton: View {
    
    let size: CGFloat
    let actionSubject: VoidSubject
    
    var body: some View {
        Button(subject: actionSubject) {
            Image(.photo)
                .resizable()
                .foregroundColor(.appDarkBlue)
                .frame(width: size, height: size)
                .padding(9)
                .background(Color.white)
                .cornerRadius(36)
                .padding(.trailing)
                .transition(.scale.animation(.spring()))
        }
        .photoChangeButtonStyle()
    }
}

struct PhotoChangeButton_Previews: PreviewProvider {
    static var previews: some View {
        PhotoChangeButton(size: 19,
                          actionSubject: VoidSubject())
    }
}
