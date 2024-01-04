//
//  TeamCell.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 21.10.2023.
//

import SwiftUI
import Combine

fileprivate struct Layout {
    static let imageSize: CGFloat = 172
    static let addPhotoSize: CGFloat = 18
}

struct TeamCell: View {
    
    @State private var isDeleting = false
    
    let isSelected: Bool
    @Binding var model: TeamModel
    
    let addPhotoSubject: VoidSubject
    let editNameSubject: StringSubject
    let deleteSubject: VoidSubject
    
    var body: some View {
        VStack(spacing: 10) {
            avatarView()
            nameView()
        }
        .onChange(of: isSelected) { newValue in
            if !newValue {
                withAnimation {
                    isDeleting = false
                }
            }
        }
        .animation(.spring(), value: isSelected)
        .animation(.easeInOut, value: isDeleting)
    }
}

private extension TeamCell {
    func avatarView() -> some View {
        Image(model.image)
            .resizable()
            .scaledToFill()
            .frame(width: Layout.imageSize, height: Layout.imageSize)
            .overlay(alignment: .center, content: deleteTeamOverlay)
            .mask { Circle() }
            .overlay(alignment: .bottomTrailing, content: addPhotoButton)
            .onLongPressGesture(minimumDuration: 0.5,
                                maximumDistance: .infinity) {
                guard isSelected else { return }
                isDeleting.toggle()
            }
    }
    
    @ViewBuilder
    func nameView() -> some View {
        if isSelected {
            TeamNameFieldButton(name: $model.name)
                .frame(height: 40)
        }
    }
    
    @ViewBuilder
    func addPhotoButton() -> some View {
        if isSelected {
            PhotoChangeButton(size: Layout.addPhotoSize,
                              actionSubject: addPhotoSubject)
        }
    }
    
    @ViewBuilder
    func deleteTeamOverlay() -> some View {
        if isDeleting {
            ZStack {
                Color.red.opacity(0.25)
                DeleteTeamButton(deleteSubject: deleteSubject)
            }
        }
    }
}


#if DEBUG
struct TeamCell_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            TeamCell(isSelected: true,
                     model: .constant(.defaultTeam1()),
                     addPhotoSubject: VoidSubject(),
                     editNameSubject: StringSubject(),
                     deleteSubject: VoidSubject())
            Spacer()
        }
    }
}
#endif
