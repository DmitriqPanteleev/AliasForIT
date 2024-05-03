//
//  BorderedTextField.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 01.05.2024.
//

import SwiftUI

struct BorderedTextField: View {
    
    @FocusState private var isActive: Bool
    
    @Binding var text: String
    let placeholder: String
    
    var body: some View {
        TextField(placeholder, text: $text)
            .padding(12)
            .overlay(content: borderOverlay)
            .focused($isActive)
            .animation(.smooth, value: isActive)
    }
}

private extension BorderedTextField {
    func borderOverlay() -> some View {
        RoundedRectangle(cornerRadius: .infinity)
            .stroke(isActive ? Color.appDarkBlue : .appGray,
                    lineWidth: 2)
    }
}

#Preview {
    BorderedTextField(text: .constant("text"), placeholder: "")
}
