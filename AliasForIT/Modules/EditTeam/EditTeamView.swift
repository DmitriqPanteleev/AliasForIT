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
        
        VStack(alignment: .leading, spacing: 10) {
            RoundedTextField(teamName: viewModel.output.name, placeholder: "Название команды")
            
            defaultImages
            pickImageButtons
            confirmButton
        }
        .frame(height: UIScreen.main.bounds.height)
        .padding(.horizontal)
        .background(Color.appBackground.ignoresSafeArea())
        .onDisappear {
            viewModel.input.onSave.send()
        }
    }
}

private extension EditTeamView {
    var defaultImages: some View {
        
        VStack {
            Text("Аватарка")
                .titleThreeWhite()
            
            // TODO: add an assets to pick the default images
            //            LazyVGrid(
            //                columns: columns,
            //                alignment: .center,
            //                spacing: 16,
            //                pinnedViews: [.sectionHeaders, .sectionFooters]
            //            ) {
            //                Section(header: Text("Section 1").font(.title)) {
            //                    ForEach(0...10, id: \.self) { index in
            //
            //                    }
            //                }
            //
            //                Section(header: Text("Section 2").font(.title)) {
            //                    ForEach(11...20, id: \.self) { index in
            //
            //                    }
            //                }
            //            }
        }
    }
    
    var pickImageButtons: some View {
        VStack {
            Text("Выбрать аватарку из галлереи")
                .titleThreeWhite()
            
            HStack {
                
            }
        }
    }
    
    var confirmButton: some View {
        PlayButtonView(style: .next) {
            viewModel.input.onSave.send()
        }
    }
}

//struct EditTeamView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditTeamView(model: TeamModel.defaultTeam1())
//    }
//}

