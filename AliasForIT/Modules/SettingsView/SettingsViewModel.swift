//
//  SettingsViewModel.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 15.11.2022.
//

import Foundation

import Foundation
import Combine

final class SettingsViewModel: ObservableObject {
    
    
    let input: Input
    @Published var output: Output
    
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        self.input = Input()
        self.output = Output()
        
        setupBindings()
    }
    
    func setupBindings() {
        setupOnChangePoints()
        setupOnChangeRoundTime()
        setupOnChangeAudio()
        setupOnChangeLastWord()
    }
    
    func setupOnChangePoints() {
        input.onChangePoints
            .sink {
                UserStorage.shared.pointsForWin += $0
                self.output.points = UserStorage.shared.pointsForWin
            }
            .store(in: &cancellable)
    }
    
    func setupOnChangeRoundTime() {
        input.onChangeRoundTime
            .sink {
                UserStorage.shared.roundTime += $0
                self.output.roundTime = UserStorage.shared.roundTime
            }
            .store(in: &cancellable)
    }
    
    func setupOnChangeAudio() {
        input.onChangeAudio
            .sink {
                UserStorage.shared.isSoundActive = $0
                self.output.audio = UserStorage.shared.isSoundActive
            }
            .store(in: &cancellable)
    }
    
    func setupOnChangeLastWord() {
        input.onChangeLastWord
            .sink {
                UserStorage.shared.isCommonLastWord = $0
                self.output.lastWord = UserStorage.shared.isCommonLastWord
            }
            .store(in: &cancellable)
    }
    
    struct Input {
        let onChangePoints = PassthroughSubject<Int, Never>()
        let onChangeRoundTime = PassthroughSubject<Int, Never>()
        let onChangeAudio = PassthroughSubject<Bool, Never>()
        let onChangeLastWord = PassthroughSubject<Bool, Never>()
    }
    
    struct Output {
        var points: Int = UserStorage.shared.pointsForWin
        var roundTime: Int = UserStorage.shared.roundTime
        var audio: Bool = UserStorage.shared.isSoundActive
        var lastWord: Bool = UserStorage.shared.isCommonLastWord
    }
}
