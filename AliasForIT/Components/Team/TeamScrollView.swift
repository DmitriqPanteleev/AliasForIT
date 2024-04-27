//
//  TeamScrollView.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 22.10.2023.
//

import SwiftUI
import Combine

struct TeamScrollView: View {
    
    @Binding var selectedTeam: Identifier
    @Binding var models: [TeamModel]
    
    let addPhotoSubject: VoidSubject
    let editNameSubject: StringSubject
    let deleteSubject: VoidSubject
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 30) {
                ForEach(models.indices, id: \.hashValue) { index in
                    cellView($models[index], for: index)
                }
            }
            .offset(x: ((UIScreen.main.bounds.width - 178) / 2) - CGFloat((selectedTeam * (208))))
            .padding(.vertical, 26)
        }
        .scrollDisabled(true)
    }
}

private extension TeamScrollView {
    
    func cellView(_ model: Binding<TeamModel>, for index: Int) -> some View {
        TeamCell(isSelected: index == selectedTeam,
                 model: model,
                 addPhotoSubject: addPhotoSubject,
                 editNameSubject: editNameSubject,
                 deleteSubject: deleteSubject)
        .scaleEffect(index == selectedTeam ? 1 : 0.85, anchor: .bottom)
        .blur(radius: index == selectedTeam ? 0 : 1)
        .onTapGesture {
            withAnimation {
                selectedTeam = index
            }
        }
        .gesture(drag)
    }
    
    var drag: some Gesture {
        DragGesture(minimumDistance: 10)
            .onEnded { value in
                if value.translation.width < -50, selectedTeam < models.count - 1 {
                    withAnimation {
                        selectedTeam += 1
                    }
                    return
                } else if value.translation.width > 50, selectedTeam > 0 {
                    withAnimation {
                        selectedTeam -= 1
                    }
                    return
                }
            }
    }
}

#if DEBUG
struct TeamScrollView_Previews: PreviewProvider {
    static var previews: some View {
        TeamScrollView(selectedTeam: .constant(0),
                       models: .constant([.defaultTeam1(), .defaultTeam2(), .defaultTeam1()]),
                       addPhotoSubject: VoidSubject(),
                       editNameSubject: StringSubject(),
                       deleteSubject: VoidSubject())
    }
}
#endif
