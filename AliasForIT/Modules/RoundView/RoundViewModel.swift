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
    //TODO: make a router
    
    //MARK: - Variables
    let roundModel: RoundModel
    var roundDuration: Int
    
    let input: Input
    @Published var output: Output
    
    private var timer: Publishers.Autoconnect<Timer.TimerPublisher>?
    private var cancellable = Set<AnyCancellable>()
    
    init(roundModel: RoundModel, roundDuration: Int) {
        self.roundModel = roundModel
        self.roundDuration = roundDuration
        
        self.input = Input()
        self.output = Output()
        
        setupBindings()
    }
    
    deinit {
        print("\(self) DEINITED!!!")
        
        cancellable.forEach { $0.cancel() }
        cancellable.removeAll()
    }
    
    //MARK: - Bindings
    func setupBindings() {
        setupTimer()
        setupPass()
        setupDone()
    }
    
    func setupTimer() {
        input.timerState
            .sink { [weak self] in
                guard let self = self else { return }
                
                if $0 && self.timer == nil {
                    self.output.roundTime = self.roundDuration
                    self.timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
                    
                    self.setupTime()
                } else {
                    self.roundDuration = self.output.roundTime
                    self.timer?.upstream.connect().cancel()
                    self.timer = nil
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
                }
            }
            .store(in: &cancellable)
    }
    
    func setupPass() {
        input.pass
            .sink { [weak self] in
                self?.output.answeredWords[$0] = false
            }
            .store(in: &cancellable)
    }
    
    func setupDone() {
        input.done
            .sink { [weak self] in
                self?.output.answeredWords[$0] = true
            }
            .store(in: &cancellable)
    }
    
    
    struct Input {
        let onAppear = PassthroughSubject<Void, Never>()
        let timerState = PassthroughSubject<Bool, Never>()
        
        let pass = PassthroughSubject<String, Never>()
        let done = PassthroughSubject<String, Never>()
    }
    
    struct Output {
        var roundTime: Int = 10
        var answeredWords: [String: Bool] = [:]
    }
}

