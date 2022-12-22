//
//  RoundFinishedView.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 09.12.2022.
//

import SwiftUI
import Combine

struct RoundFinishedView: View {
    
    @EnvironmentObject var router: RoundCoordinator.Router
    
    @State var answeredWords: [AnswerModel]
    let sendScore: PassthroughSubject<Int, Never>
    
    var body: some View {
        VStack {
            ScrollView {
                AnimatedAppBar(title: "Раунд завершен", subtitle: "Итого: \(answeredWords.filter { $0.isAnswered == true }.count)")
                    .padding(.bottom, 120)
                    .padding(.horizontal)
                
                table
            }
            
            button
        }
        .navigationBarBackButtonHidden(true)
        .background(Color.appBackground.ignoresSafeArea())
    }
}

private extension RoundFinishedView {
    
    var table: some View {
        SharpedCardView {
            ForEach($answeredWords) { model in
                AnswerToggleCell(model: model)
            }
        }
        .padding([.horizontal, .bottom])
    }
    
    var button: some View {
        PlayButtonView(style: .next, action: {
            router.popToRoot {
                sendScore.send(answeredWords.filter { $0.isAnswered == true }.count)
            }
        })
        .padding(.horizontal)
    }
}

//struct RoundFinishedView_Previews: PreviewProvider {
//    static var previews: some View {
//        RoundFinishedView(answeredWords: [
//            AnswerModel(word: "Slovo", isAnswered: false),
//            AnswerModel(word: "Slovo", isAnswered: true),
//            AnswerModel(word: "Slovo", isAnswered: true),
//            AnswerModel(word: "Slovo", isAnswered: false),
//            AnswerModel(word: "Slovo", isAnswered: true),
//            AnswerModel(word: "Slovo", isAnswered: false),
//            AnswerModel(word: "Slovo", isAnswered: true),
//            AnswerModel(word: "Slovo", isAnswered: false),
//            AnswerModel(word: "Slovo", isAnswered: true),
//            AnswerModel(word: "Slovo", isAnswered: false),
//            AnswerModel(word: "Slovo", isAnswered: true),
//            AnswerModel(word: "Slovo", isAnswered: true),
//            AnswerModel(word: "Slovo", isAnswered: false),
//            AnswerModel(word: "Slovo", isAnswered: true)
//        ],
//                          sendScore: PassthroughSubject<Int, Never>())
//    }
//}
