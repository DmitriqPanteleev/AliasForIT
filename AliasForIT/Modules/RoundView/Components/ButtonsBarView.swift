//
//  ButtonsBar.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 02.12.2022.
//

import SwiftUI

struct ButtonsBarView: View {
    
    let passButtonAction: () -> Void
    let doneButtonAction: () -> Void
    var body: some View {
        HStack(alignment: .center) {
            RoundButtonView(style: .pass, action: passButtonAction)
            Spacer()
            RoundButtonView(style: .done, action: doneButtonAction)
        }
        .frame(width: (Consts.SharedLayout.cardWidth), alignment: .center)
    }
}

//struct ButtonsBarView_Previews: PreviewProvider {
//    static var previews: some View {
//        ButtonsBarView()
//    }
//}
