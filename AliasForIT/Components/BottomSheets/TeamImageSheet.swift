//
//  TeamImageBottomSheet.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 22.04.2024.
//

import SwiftUI

// TODO: Refactor
struct TeamImageSheet: View {
    
    @State private var selected: TeamImage?
    
    @Binding var isShowing: Bool
    
    let confirmSubject: ImageSubject
    
    var body: some View {
        VStack {
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 12) {
                    ForEach(TeamImage.allCases, id: \.hashValue) { image in
                        Image(image)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 140, height: 140)
                            .cornerRadius(.infinity)
                            .overlay { selectedOverlay(image) }
                            .onTapGesture {
                                selected = image
                            }
                    }
                }
                .padding()
            }
        }
        .padding(.vertical)
        .safeAreaInset(edge: .bottom, content: confirmButton)
    }
}

private extension TeamImageSheet {
    @ViewBuilder
    func selectedOverlay(_ image: TeamImage) -> some View {
        if image == selected {
            ring(color: .white)
                .padding(2)
                .overlay { ring(color: .appDarkGray) }
        }
    }
    
    func ring(color: Color) -> some View {
        RoundedRectangle(cornerRadius: .infinity)
            .stroke(lineWidth: 2)
            .fill(color)
    }
    
    func confirmButton() -> some View {
        Button(action: confirmChoice) {
            Text("Готово")
                .buttonTitle()
        }
        .textButtonStyle(disabled: selected == nil)
        .padding(.horizontal)
    }
}

private extension TeamImageSheet {
    func confirmChoice() {
        guard let selected = selected else { return }
        defer { confirmSubject.send(selected) }
        isShowing = false
    }
}

#Preview {
    TeamImageSheet(isShowing: .constant(true), confirmSubject: ImageSubject())
}
