//
//  RoundedTextField.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 12.12.2022.
//

import SwiftUI

struct RoundedTextField: View {
    
    @State private var text = ""
    
    @Binding var teamName: String
    let placeholder: String
    
    init(teamName: Binding<String>, placeholder: String) {
        self._teamName = teamName
        self.placeholder = placeholder
        self._text = State(initialValue: teamName.wrappedValue)
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(placeholder)
                .titleThreeWhite()
            
            textField
            .background(Color.appBackground.ignoresSafeArea())
        }
        .frame(alignment: .leading)
    }
}

private extension RoundedTextField {
    
    var textField: some View {
        ZStack(alignment: .trailing) {
            overlayRectangle
            TextField(placeholder, text: $text)
                .font(.system(size: 15, weight: .regular))
                .foregroundColor(.white)
                .background(Color.appBackground)
                .padding(10)
                .onChange(of: text, perform: { newValue in
                    teamName = newValue
                })
            clearButton
                .padding(.trailing, 12)
        }
    }
    var overlayRectangle: some View {
        RoundedRectangle(cornerRadius: 10).stroke(Color.appOrange ,lineWidth: 1)

            .frame(height: 40)
        
    }
    
    @ViewBuilder var clearButton: some View {
        if !text.isEmpty {
            Button(action: clearButtonAction) {
                Image(systemName: "xmark")
                    .foregroundColor(.white)
            }
        }
    }
}

private extension RoundedTextField {
    
    func clearButtonAction() {
        text = ""
    }
}

//struct RoundedTextField_Previews: PreviewProvider {
//    static var previews: some View {
//        RoundedTextField()
//    }
//}
