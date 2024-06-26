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
    
    @Binding var model: TeamModel
    
    let isSelected: Bool
    let isDeletingEnabled: Bool
    let addPhotoSubject: VoidSubject
    let editNameSubject: StringSubject
    let deleteSubject: VoidSubject
    
    var body: some View {
        VStack(spacing: 10) {
            avatarView
            nameView
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
        .animation(.smooth, value: model.image)
    }
}

private extension TeamCell {
    var avatarView: some View {
        Image(model.image)
            .resizable()
            .scaledToFill()
            .frame(width: Layout.imageSize, height: Layout.imageSize)
            .overlay(alignment: .center, content: deleteTeamOverlay)
            .mask { Circle() }
            .overlay(alignment: .bottomTrailing, content: addPhotoButton)
            .onLongPressGesture(minimumDuration: 0.5,
                                maximumDistance: .infinity) {
                guard isSelected, isDeletingEnabled else { return }
                isDeleting.toggle()
            }
    }
    
    @ViewBuilder
    var nameView: some View {
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
            TeamCell(model: .constant(.defaultTeam1()),
                     isSelected: true,
                     isDeletingEnabled: false,
                     addPhotoSubject: VoidSubject(),
                     editNameSubject: StringSubject(),
                     deleteSubject: VoidSubject())
            Spacer()
        }
    }
}
#endif
