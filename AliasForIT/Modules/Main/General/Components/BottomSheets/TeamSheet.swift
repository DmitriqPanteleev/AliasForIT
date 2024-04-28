//
//  TeamImageBottomSheet.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 22.04.2024.
//

import SwiftUI

struct TeamSheet: View {
    
    @State private var teamName: String = ""
    @State private var selectedImage: TeamImage?
    
    @Binding var isShowing: Bool
    
    let type: TeamSheetType
    let confirmSubject: TeamSheetSubject
    
    private var isButtonEnabled: Bool {
        (type == .adding && !teamName.isEmpty && selectedImage != nil) ||
        (type == .editing && selectedImage != nil)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            imagesView
            teamNameView
        }
        .padding(.vertical)
        .safeAreaInset(edge: .bottom, content: confirmButton)
    }
}

private extension TeamSheet {
    var imagesView: some View {
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
                            selectedImage = image
                        }
                }
            }
            .padding()
        }
    }
    
    @ViewBuilder
    func selectedOverlay(_ image: TeamImage) -> some View {
        if image == selectedImage {
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
    
    @ViewBuilder
    var teamNameView: some View {
        if type == .adding {
            TextField("Имя команды", text: $teamName)
                .textFieldStyle(.plain)
                .padding(.horizontal)
        }
    }
    
    func confirmButton() -> some View {
        Button(action: confirmChoice) {
            Text("Готово")
                .buttonTitle()
        }
        .textButtonStyle(disabled: !isButtonEnabled)
        .padding(.horizontal)
    }
}

private extension TeamSheet {
    func confirmChoice() {
        guard let selected = selectedImage else { return }
        
        defer {
            let config = TeamSheetConfig(type: type,
                                         image: selected,
                                         name: teamName)
            confirmSubject.send(config)
        }
        
        isShowing = false
    }
}

#Preview {
    TeamSheet(isShowing: .constant(false),
              type: .adding,
              confirmSubject: TeamSheetSubject())
}
