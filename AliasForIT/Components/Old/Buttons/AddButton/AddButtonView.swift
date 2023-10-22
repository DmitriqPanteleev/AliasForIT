//
//  AddButtonView.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 12.12.2022.
//

import SwiftUI
import Combine

struct AddButtonView: View {
    
    let onTap: () -> Void
    
    var body: some View {
        VStack {
            Image(systemName: "plus")
        }
        .frame(width: 30, height: 30)
        .foregroundColor(.white)
        .background(LinearGradient(
            colors: [.appYellow, .appOrange],
            startPoint: .bottomLeading,
            endPoint: .center))
        .cornerRadius(15)
        .shadow(radius: 4, x: 0, y: 4)
        .onTapGesture(perform: onTap)
    }
}

struct AddButtonView_Previews: PreviewProvider {
    static var previews: some View {
        AddButtonView(onTap: {})
    }
}
