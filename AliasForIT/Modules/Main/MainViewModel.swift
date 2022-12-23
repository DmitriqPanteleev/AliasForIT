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
    
    let onUpdate: PassthroughSubject<Void, Never>
    
    let input: Input
    @Published var output: Output
    
    private var cancellable = Set<AnyCancellable>()
    
    init(onUpdate: PassthroughSubject<Void, Never>, router: MainRouter?) {
        
        self.router = router
        
        self.onUpdate = onUpdate
        
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
        bindOnUpdate()
        
        bindOnAddTap()
        bindOnDeleteTap()
        bindOnSettingsTap()
        bindOnPlayTap()
    }
    
    func bindOnAppear() {
        input.onAppear
            .sink {
                self.output.teams = TeamsStorage.shared.teams
                self.output.roundTime = UserStorage.shared.roundTime
                self.output.wordsForWin = UserStorage.shared.pointsForWin
            }
            .store(in: &cancellable)
    }
    
    func bindOnUpdate() {
        self.onUpdate
            .sink {
                self.input.onAppear.send()
            }
            .store(in: &cancellable)
    }
    
    func bindOnAddTap() {
        input.onAddTap
            .sink { [weak self] model in
                self?.router?.moveToEditTeam(model: model)
            }
            .store(in: &cancellable)
    }
    
    func bindOnDeleteTap() {
        input.onDelete
            .sink { [weak self] id in
                
                let index = TeamsStorage.shared.teams.firstIndex {
                    $0.id == id
                }
                
                TeamsStorage.shared.teams.remove(at: index!)
                
                self?.input.onAppear.send()
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
        
        let onAddTap = PassthroughSubject<TeamModel?, Never>()
        let onDelete = PassthroughSubject<Int, Never>()
        
        let onSettingsTap = PassthroughSubject<Void, Never>()
        let onRulesTap = PassthroughSubject<Void, Never>()
        
        let onPlayTap = PassthroughSubject<Void, Never>()
        let onExitTap = PassthroughSubject<Void, Never>()
    }
    
    struct Output {
        var teams: [TeamModel] = TeamsStorage.shared.teams
        
        var roundTime = UserStorage.shared.roundTime
        var wordsForWin = UserStorage.shared.pointsForWin
    }
}
