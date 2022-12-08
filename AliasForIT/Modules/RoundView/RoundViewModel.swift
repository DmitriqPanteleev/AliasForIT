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
    
    let input: Input
    @Published var output: Output
    
    private var timer: Publishers.Autoconnect<Timer.TimerPublisher>?
    private var cancellable = Set<AnyCancellable>()
    
    init(roundModel: RoundModel, router: RoundRouter?) {
        
        self.roundModel = roundModel
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
        setupTimer()
        setupAnswer()
    }
    
    func setupTimer() {
        input.timerState
            .sink { [weak self] in
                guard let self = self else { return }
                
                if $0 && self.timer == nil {
                    self.output.roundTime = self.roundModel.roundDuration
                    self.timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
                    
                    self.setupTime()
                } else {
                    self.roundModel.roundDuration = self.output.roundTime
                    self.timer?.upstream.connect().cancel()
                    self.timer = nil
                    self.output.isTimerTicking = false
                }
            }
            .store(in: &cancellable)
    }
    
    func setupTime() {
        timer?
            .sink { [weak self] _ in

                guard let self = self else { return }
                
                if self.output.roundTime > 0 {
                    self.output.roundTime -= 1
                    self.input.onAppear.send()
                } else {
                    self.input.timerState.send(false)
                    // navigate to the next screen with answers
                    self.router?.pop()
                }
            }
            .store(in: &cancellable)
    }
    
    func setupAnswer() {
        input.answer
            .sink { [weak self] in
                guard let self = self else { return }
                
                self.output.answeredWords[self.output.currentWord] = $0
                self.output.currentIndex += 1
                
                if $0 {
                    self.output.currentScore += 1
                }
                
                self.output.currentWord = self.roundModel.words[self.output.currentIndex]
                self.input.onAppear.send()
            }
            .store(in: &cancellable)
    }
    
    struct Input {
        let onAppear = PassthroughSubject<Void, Never>()
        let timerState = PassthroughSubject<Bool, Never>()
        let answer = PassthroughSubject<Bool, Never>()
    }
    
    struct Output {
        var isTimerTicking: Bool = true
        var roundTime: Int = 10
        var currentIndex: Int = 0
        var currentWord: String = ""
        var currentScore: Int = 0
        var answeredWords: [String: Bool] = [:]
    }
}

