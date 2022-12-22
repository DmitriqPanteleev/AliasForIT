//
//  MainViewModel.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 12.12.2022.
//

import Foundation
import Combine

final class MainViewModel: ObservableObject {
    
    private weak var router: MainRouter?
    
    let onSetSettings: PassthroughSubject<Void, Never>
    
    let input: Input
    @Published var output: Output
    
    private var cancellable = Set<AnyCancellable>()
    
    init(onSetSettings: PassthroughSubject<Void, Never>, router: MainRouter?) {
        
        self.router = router
        
        self.onSetSettings = onSetSettings
        
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
    
    func setupBindings() {
        
        bindOnAppear()
        
        bindOnSettingsTap()
        bindOnPlayTap()
        
        bindOnSetSettings()
    }
    
    func bindOnAppear() {
        input.onAppear
            .sink {
                self.output.roundTime = UserStorage.shared.roundTime
                self.output.wordsForWin = UserStorage.shared.pointsForWin
            }
            .store(in: &cancellable)
    }
    
    func bindOnSetSettings() {
        self.onSetSettings
            .sink {
                self.input.onAppear.send()
            }
            .store(in: &cancellable)
    }
    
    
    func bindOnSettingsTap() {
        input.onSettingsTap
            .sink {
                self.router?.moveToSettings()
            }
            .store(in: &cancellable)
    }
    
    func bindOnPlayTap() {
        input.onPlayTap
            .sink { [weak self] in
                
                guard let self = self else { return }
                
                self.router?.moveToGame(teams: self.output.teams)
            }
            .store(in: &cancellable)
    }
    
    func bindOnExitTap() {
        input.onExitTap
            .sink { [weak self] in
                self?.router?.closeApp()
            }
            .store(in: &cancellable)
    }
    
    struct Input {
        let onAppear = PassthroughSubject<Void, Never>()
        
        let editState = PassthroughSubject<Bool, Never>()
        let onAddTap = PassthroughSubject<TeamModel?, Never>()
        let confirmAdd = PassthroughSubject<TeamModel, Never>()
        let onDelete = PassthroughSubject<Int, Never>()
        
        let onSettingsTap = PassthroughSubject<Void, Never>()
        let onRulesTap = PassthroughSubject<Void, Never>()
        
        let onPlayTap = PassthroughSubject<Void, Never>()
        let onExitTap = PassthroughSubject<Void, Never>()
    }
    
    struct Output {
        var teams: [TeamModel] = [.defaultTeam1(), .defaultTeam2()]
        
        var roundTime = UserStorage.shared.roundTime
        var wordsForWin = UserStorage.shared.pointsForWin
    }
}
