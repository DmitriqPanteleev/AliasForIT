//
//  EditTeamView.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 20.12.2022.
//

import SwiftUI

struct EditTeamView: View {
    
    @StateObject var viewModel: EditTeamViewModel
    
    private let columns = [GridItem(.flexible()), GridItem(.flexible()), GridItem(.flexible())]
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 20) {
            
            RoundedTextField(teamName: $viewModel.output.name, placeholder: "Название команды")
            
            defaultImages
                .padding(.bottom, 30)
            
            confirmButton
        }
        .frame(height: UIScreen.main.bounds.height)
        .padding(.horizontal)
        .background(Color.appBackground.ignoresSafeArea())
    }
}

private extension EditTeamView {
    
    var defaultImages: some View {
        
        VStack(alignment: .leading, spacing: 10) {
            
            Text("Аватарка")
                .titleThreeWhite()
            
            LazyVGrid(columns: columns, alignment: .center, spacing: 10) {
                
                ForEach(viewModel.output.images, id: \.self) { image in
                    AvatarCellView(isSelected: $viewModel.output.isSelectedImage, image: image)
                        .onTapGesture {
                            viewModel.input.onImageTap.send(image)
                        }
                }
            }
        }
    }
    
    var confirmButton: some View {
        PlayButtonView(style: .next, action: save)
            .disabled(viewModel.output.isSelectedImage.isEmpty && viewModel.output.name.isEmpty)
    }
}

private extension EditTeamView {
    
    func save() {
        viewModel.input.onSaveTap.send()
    }
    
}

//struct EditTeamView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditTeamView(model: TeamModel.defaultTeam1())
//    }
//}

