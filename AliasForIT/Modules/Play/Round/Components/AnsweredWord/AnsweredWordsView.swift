//
//  AnsweredWordsView.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 02.05.2024.
//

import SwiftUI

struct AnsweredWordsView: View {
    
    @Binding var words: [AnswerModel]
    
    var body: some View {
        VStack(spacing: 0) {
            ScrollView(showsIndicators: false) {
                ForEach($words) { model in
                    AnsweredWordCell(model: model)
                }
                .padding(.horizontal)
                .padding(.bottom, 64)
            }
        }
    }
}

#Preview {
    AnsweredWordsView(words: .constant([]))
}
