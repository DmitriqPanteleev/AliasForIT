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
    
    let isSelected: Bool
    @Binding var model: TeamModel
    
    let addPhotoSubject: VoidSubject
    let editNameSubject: StringSubject
    
    var body: some View {
        VStack(spacing: 10) {
            avatarView()
            nameView()
        }
        .animation(.spring(), value: isSelected)
    }
}

private extension TeamCell {
    func avatarView() -> some View {
        Image(model.image)
            .resizable()
            .scaledToFill()
            .frame(width: Layout.imageSize, height: Layout.imageSize)
            .mask { Circle() }
            .overlay(alignment: .bottomTrailing, content: addPhotoButton)
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
}


#if DEBUG
struct TeamCell_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Spacer()
            TeamCell(isSelected: true,
                     model: .constant(.defaultTeam1()),
                     addPhotoSubject: VoidSubject(),
                     editNameSubject: StringSubject())
            Spacer()
        }
    }
}
#endif
