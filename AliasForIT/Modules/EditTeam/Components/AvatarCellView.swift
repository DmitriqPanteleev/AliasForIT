//
//  AvatarCellView.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 23.12.2022.
//

import SwiftUI

struct AvatarCellView: View {
    
    @Binding var isSelected: String
    let image: String
    
    var body: some View {
        Image(image)
            .resizable()
            .scaledToFill()
            .frame(width: UIScreen.main.bounds.width * (80/375), height: UIScreen.main.bounds.width * (80/375))
            .cornerRadius(160)
            .overlay(
                RoundedRectangle(cornerRadius: 160).stroke(lineWidth: 1)
                    .foregroundColor(isSelected == image ? .appOrange : .appCard)
            )
    }
}

//struct AvatarCellView_Previews: PreviewProvider {
//    static var previews: some View {
//        AvatarCellView()
//    }
//}
