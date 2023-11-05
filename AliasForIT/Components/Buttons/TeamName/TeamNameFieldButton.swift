//
//  TeamNameFieldButton.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 05.11.2023.
//

import SwiftUI

struct TeamNameFieldButton: View {
    
    @State private var isEdit = false
    @FocusState private var textFieldFocused
    
    @Binding var name: String
    
    var body: some View {
        contentView
            .animation(.spring(), value: isEdit)
    }
}

private extension TeamNameFieldButton {
    
    var contentView: some View {
        HStack(spacing: 8) {
            Spacer()
            if isEdit {
                TextField("", text: $name)
                    .foregroundColor(.appDarkBlue)
                    .font(.system(size: 20, weight: .light))
                    .focused($textFieldFocused)
                    .transition(.scale(scale: 0, anchor: .bottom).combined(with: .move(edge: .bottom).animation(.default.delay(0.1))))
            } else {
                Text(name)
                    .foregroundColor(.appDarkBlue)
                    .font(.system(size: 20, weight: .light))
                    .frame(maxWidth: 160)
                    .lineLimit(1)
                    .transition(.scale(scale: 0, anchor: .top).combined(with: .move(edge: .top).animation(.default.delay(0.1))))
                    .onTapGesture {
                        guard !isEdit else { return }
                        isEdit = true
                        textFieldFocused = true
                    }
            }
            
            if isEdit {
                doneButtonView
            }
            Spacer()
        }
        .frame(maxWidth: 160)
        .padding(.vertical, isEdit ? 10 : 0)
        .background(Color.white)
        .cornerRadius(isEdit ? 10 : 0)
        .shadow(color: .black.opacity(isEdit ? 0.05 : 0), radius: 6, y: 12)
    }
    
    var doneButtonView: some View {
        Image(.checkMark)
            .resizable()
            .scaledToFit()
            .frame(height: 24)
            .foregroundColor(.appDarkBlue)
            .transition(.scale(scale: 0))
            .onTapGesture {
                guard isEdit else { return }
                isEdit = false
                textFieldFocused = false
            }
    }
}

struct TeamNameFieldButton_Previews: PreviewProvider {
    static var previews: some View {
        TeamNameFieldButton(name: .constant("Имя команды"))
    }
}
