//
//  RoundViewModel.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 15.11.2022.
//

import Foundation
import Combine

final class RoundViewModel: ObservableObject {
    
    //MARK: - Services
    private weak var router: RoundRouter?
    
    //MARK: - Variables
    var roundModel: RoundModel
    let onRoundFinish: PassthroughSubject<Int, Never>
    
    let input: Input
    @Published var output: Output
    
    private var timer: Publishers.Autoconnect<Timer.TimerPublisher>?
    private var cancellable = Set<AnyCancellable>()
    
    init(roundModel: RoundModel,
         onRoundFinish: PassthroughSubject<Int, Never>,
         router: RoundRouter?) {
        
        self.roundModel = roundModel
        self.onRoundFinish = onRoundFinish
        self.router = router
        
        self.input = Input()
        self.output = Output()
        
        setupBindings()
    }
    
    deinit {
        #if DEBUG
        print("\(self) DEINITED!!!")
        #endif
        
        cancellable.forEach { $0.cancel() }
        cancellable.removeAll()
    }
    
    //MARK: - Bindings
    func setupBindings() {
        self.output.currentWord = roundModel.words.first!
        self.output.currentIndex = 0
        
        bindTimer()
        bindAnswer()
        bindState()
        bindOnCloseTap()
    }
    
    func bindTimer() {
        input.timerState
            .sink { [weak self] in
                guard let self = self else { return }
                
                if $0 && self.timer == nil {
                    self.output.roundTime = self.roundModel.roundDuration
                    self.timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
                    
                    self.bindTime()
                } else {
                    self.roundModel.roundDuration = self.output.roundTime
                    self.timer?.upstream.connect().cancel()
                    self.timer = nil
                    self.output.isTimerTicking = false
                }
            }
            .store(in: &cancellable)
    }
    
    func bindTime() {
        timer?
            .sink { [weak self] _ in

                guard let self = self else { return }
                
                if self.output.roundTime > 0 {
                    self.output.roundTime -= 1
                    self.input.onAppear.send()
                } else {
                    self.input.timerState.send(false)
                    self.router?.moveToFinish(answeredWords: self.output.answeredWords)
                }
            }
            .store(in: &cancellable)
    }
    
    func bindAnswer() {
        input.answer
            .sink { [weak self] in
                guard let self = self else { return }
                
                let answerModel = AnswerModel(word: self.output.currentWord, isAnswered: $0)
                self.output.answeredWords.append(answerModel)
                
                self.output.currentIndex += 1
                
                if $0 {
                    self.output.currentScore += 1
                }
                
                self.output.currentWord = self.roundModel.words[self.output.currentIndex]
                self.input.onAppear.send()
            }
            .store(in: &cancellable)
    }
    
    func bindState() {
        input.timerState
            .sink { [weak self] in
                
                if $0 {
                    self?.output.state = .playing
                } else {
                    self?.output.state = .paused
                }
            }
            .store(in: &cancellable)
    }
    
    func bindOnCloseTap() {
        input.onCloseTap
            .sink {
                self.router?.moveToFinish(answeredWords: self.output.answeredWords)
            }
            .store(in: &cancellable)
    }
    
    struct Input {
        let onAppear = PassthroughSubject<Void, Never>()
        let timerState = PassthroughSubject<Bool, Never>()
        let answer = PassthroughSubject<Bool, Never>()
        let onCloseTap = PassthroughSubject<Void, Never>()
    }
    
    struct Output {
        var state: RoundViewState = .playing
        var isTimerTicking: Bool = true
        var roundTime: Int = 10
        var currentIndex: Int = 0
        var currentWord: String = ""
        var currentScore: Int = 0
        var answeredWords: [AnswerModel] = []
    }
}

// сделать адекватно, на подумать
enum RoundViewState {
    case playing
    case paused
}
