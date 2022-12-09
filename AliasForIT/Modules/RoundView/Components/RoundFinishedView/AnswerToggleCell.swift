//
//  AnswerToggleCell.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 09.12.2022.
//

import SwiftUI

struct AnswerToggleCell: View {
    
    @State var model: AnswerModel
    
    var body: some View {
        cell(model.word, isAnswered: $model.isAnswered)
    }
}

private extension AnswerToggleCell {
    @ViewBuilder func cell(_ word: String, isAnswered: Binding<Bool>) -> some View {
        
        HStack {
            if isAnswered.wrappedValue {
                Text(word)
                    .titleThreeYellow()
            } else {
                Text(word)
                    .titleThreeWhite()
            }
            
            Spacer()
            
            Toggle("", isOn: isAnswered)
                .labelsHidden()
                .tint(.appYellow)
                .onTapGesture {
                    model.isAnswered = !model.isAnswered
                }
        }
    }
}

struct AnswerToggleCell_Previews: PreviewProvider {
    static var previews: some View {
        AnswerToggleCell(model: AnswerModel(word: "Word", isAnswered: true))
    }
}
