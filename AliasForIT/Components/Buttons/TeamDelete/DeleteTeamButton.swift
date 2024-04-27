//
//  DeleteTeamButton.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 06.11.2023.
//

import SwiftUI

struct DeleteTeamButton: View {
    
    @State private var isDeleteAnimation = false
    let deleteSubject: VoidSubject
    
    var body: some View {
        ZStack {
            Circle()
                .fill(Color.red.opacity(0.5))
                .frame(width: isDeleteAnimation ? 88 : 22, height: isDeleteAnimation ? 88 : 22)
                .opacity(isDeleteAnimation ? 0.01 : 0.8)
                .animation(.easeOut(duration: 1).repeatForever(autoreverses: false),
                           value: isDeleteAnimation)
            
            Button(subject: deleteSubject) {
                Image(.removeTeam)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 44)
                    .foregroundColor(.white)
            }
            .scaledButtonStyle()
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.15) {
                isDeleteAnimation = true
            }
        }
        .onDisappear {
            isDeleteAnimation = false
        }
    }
    
    private func deleteAction() {
        
    }
}

struct DeleteTeamButton_Previews: PreviewProvider {
    static var previews: some View {
        DeleteTeamButton(deleteSubject: VoidSubject())
    }
}
