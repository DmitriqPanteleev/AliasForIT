//
//  RoundViewModel.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 15.11.2022.
//

import Foundation
import Combine

final class RoundViewModel: ObservableObject {
    
    //MARK: Services
    private let settingsManager: GameConfigurable
    private weak var router: RoundRouter?
    
    // MARK: Variables
    var roundModel: RoundModel
    let onRoundFinish: PassthroughSubject<Int, Never>
    
    let input: Input
    @Published var output: Output
    
    // MARK: Internal
    private var timer: Publishers.Autoconnect<Timer.TimerPublisher>?
    private var cancellable = Set<AnyCancellable>()
    
    init(roundModel: RoundModel,
         settingsManager: GameConfigurable,
         onRoundFinish: PassthroughSubject<Int, Never>,
         router: RoundRouter?) 
    {
        self.settingsManager = settingsManager
        self.router = router
        
        self.roundModel = roundModel
        self.onRoundFinish = onRoundFinish
        
        self.input = Input()
        self.output = Output(totalRoundTime: settingsManager.roundTime,
                             roundTime: settingsManager.roundTime,
                             currentWordsPair: roundModel.words.prefix(through: 2))
        
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
        bindFinish()
    }
    
    func bindTimer() {
        input.timerState
            .sink { [weak self] in
                guard let self = self else { return }
                
                if $0 && self.timer == nil {
                    self.timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
                    self.bindTime()
                } else {
                    self.timer?.upstream.connect().cancel()
                    self.timer = nil
                }
            }
            .store(in: &cancellable)
    }
    
    func bindTime() {
        timer? // TODO: разбить на фильтры
            .sink { [weak self] _ in
                guard let self = self else { return }
                
                if self.output.roundTime > 0 {
                    self.output.roundTime -= 1
                } else {
                    self.output.state = .finished
                    self.input.timerState.send(false)
                }
            }
            .store(in: &cancellable)
    }
    
    func bindAnswer() {
        input.answer
            .compactMap { [unowned self] in
                AnswerModel(word: self.output.currentWord, isAnswered: $0)
            }
            .handleEvents(receiveOutput: { [weak self] answerModel in
                guard let self = self else { return }
                
                self.output.isSwipesEnabled = false
                self.output.answeredWords.append(answerModel)
                
                self.output.currentIndex += 1
                self.output.currentWord = self.roundModel.words[self.output.currentIndex]
            })
            .delay(for: 0.75, scheduler: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.output.isSwipesEnabled = true
            }
            .store(in: &cancellable)
    }
    
    func bindState() {
        input.timerState
            .filter { [weak self] _ in
                guard let self = self else { return false }
                return self.output.state != .finished
            }
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
            .sink { [weak self] in
                guard let self = self else { return }
                self.output.state = .finished
                self.input.timerState.send(false)
            }
            .store(in: &cancellable)
    }
    
    func bindFinish() {
        input.onFinish
            .compactMap { [weak self] in
                self?.output.answeredWords.filter { $0.isAnswered }.count
            }
            .sink { [weak self] in
                self?.router?.pop(with: $0)
            }
            .store(in: &cancellable)
    }
    
    struct Input {
        let onAppear = PassthroughSubject<Void, Never>()
        let timerState = PassthroughSubject<Bool, Never>()
        let answer = PassthroughSubject<Bool, Never>()
        let onCloseTap = PassthroughSubject<Void, Never>()
        let onFinish = PassthroughSubject<Void, Never>()
    }
    
    struct Output {
        var state: RoundViewState = .playing
        var isSwipesEnabled: Bool = true
        
        var totalRoundTime: Int
        var roundTime: Int
        
        var currentIndex: Int = 0
        var currentWord: String = ""
        var currentScore: Int = 0
        var currentWordsPair: ArraySlice<String>
        
        var answeredWords: [AnswerModel] = [] {
            didSet {
                currentScore = answeredWords.filter { $0.isAnswered }.count
            }
        }
    }
}
