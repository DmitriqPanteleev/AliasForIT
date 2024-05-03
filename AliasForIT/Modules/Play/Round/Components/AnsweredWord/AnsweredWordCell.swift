//
//  AnsweredWordCell.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 02.05.2024.
//

import SwiftUI

struct AnsweredWordCell: View {
    
    @Binding var model: AnswerModel
    
    var body: some View {
        HStack {
            Text(model.word)
                .font(.system(size: 16))
                .foregroundColor(model.isAnswered ? .appDarkBlue : .appGray)
            Spacer()
            Toggle("", isOn: $model.isAnswered)
                .labelsHidden()
                .tint(.appDarkBlue)
        }
        .padding(.vertical, 5)
    }
}

#Preview {
    AnsweredWordCell(model: .constant(.init(word: "", isAnswered: false)))
}
