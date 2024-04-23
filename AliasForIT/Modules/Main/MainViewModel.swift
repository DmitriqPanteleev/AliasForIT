//
//  MainViewModel.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 12.12.2022.
//

import Foundation
import Combine

final class MainViewModel: ObservableObject {
    
    // MARK: Services
    private let teamStorage: TeamControlable & TeamEditable
    private let settingsManager: GameConfigurable
    private weak var router: MainRouter?
    
    // MARK: Variables
    let input: Input
    @Published var output: Output
    
    private var cancellable = Set<AnyCancellable>()
    
    // MARK: External
    private let onUpdate: VoidSubject
    
    init(teamStorage: TeamControlable & TeamEditable,
         settingsManager: GameConfigurable,
         onUpdate: VoidSubject,
         router: MainRouter?)
    {
        self.teamStorage = teamStorage
        self.settingsManager = settingsManager
        self.router = router
        
        self.onUpdate = onUpdate
        
        self.input = Input()
        self.output = Output(roundTime: settingsManager.roundTime,
                             wordsForWin: settingsManager.pointsForWin)
        
        bind()
    }
    
    deinit {
#if DEBUG
        print("\(self) DEINITED!!!")
#endif
        
        cancellable.forEach { $0.cancel() }
        cancellable.removeAll()
    }
}
    
private extension MainViewModel {
    func bind() {
        bindOnAppear()
        bindTeamControls()
        bindTransitions()
    }
    
    func bindOnAppear() {
        input.onAppear.first()
            .merge(with: onUpdate)
            .sink { [weak self] in
                guard let self = self else { return }
                self.output.teams = self.teamStorage.teams
                self.output.roundTime = self.settingsManager.roundTime
                self.output.wordsForWin = self.settingsManager.pointsForWin
            }
            .store(in: &cancellable)
    }
    
    func bindTeamControls() {
        input.addTeam
            .handleEvents(receiveOutput: { [weak self] model in
                self?.teamStorage.appendTeam(model)
            })
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.output.teams = self.teamStorage.teams
            }
            .store(in: &cancellable)
        
        input.deleteTeam
            .compactMap { [unowned self] in
                self.teamStorage.teams[self.output.selectedTeamId].id
            }
            .handleEvents(receiveOutput: { [weak self] id in
                self?.teamStorage.deleteTeam(by: id)
            })
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.output.teams = self.teamStorage.teams
            }
            .store(in: &cancellable)
        
        input.editTeamName
            .compactMap { [unowned self] in
                (self.teamStorage.teams[self.output.selectedTeamId].id, $0)
            }
            .handleEvents(receiveOutput: { [weak self] (id, name) in
                self?.teamStorage.editName(name, by: id)
            })
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.output.teams = self.teamStorage.teams
            }
            .store(in: &cancellable)
        
        input.editTeamImage
            .compactMap { [unowned self] in
                (self.teamStorage.teams[self.output.selectedTeamId].id, $0)
            }
            .handleEvents(receiveOutput: { [weak self] (id, image) in
                self?.teamStorage.editPhoto(image, by: id)
            })
            .sink { [weak self] _ in
                guard let self = self else { return }
                self.output.teams = self.teamStorage.teams
            }
            .store(in: &cancellable)
    }
    
    func bindTransitions() {
        input.toSettings.sink { [weak self] in
            self?.router?.moveToSettings()
        }
        .store(in: &cancellable)
        
        input.toSomeSetting
            .sink { [weak self] _ in
                
            }
            .store(in: &cancellable)
        
        input.toNewRound
            .sink { [weak self] in
                guard let self = self else { return }
                self.router?.moveToGame(teams: self.output.teams)
            }
            .store(in: &cancellable)
        
        input.toChooseImage
            .sink { [weak self] in
                self?.output.isShowingImageSheet = true
            }
            .store(in: &cancellable)
    }
}

extension MainViewModel {
    struct Input {
        // MARK: UI Lifecycle
        let onAppear = VoidSubject()
        
        // MARK: Transitions
        let toSettings = VoidSubject()
        let toNewRound = VoidSubject()
        let toSomeSetting = SettingSubject()
        
        // MARK: BS
        let toChooseImage = VoidSubject()
        
        // MARK: Teams Operations
        let addTeam = TeamSubject()
        let deleteTeam = VoidSubject()
        let editTeamName = StringSubject()
        let editTeamImage = ImageSubject()
    }
    
    struct Output {
        // MARK: States
        var teams: [TeamModel] = []
        var selectedTeamId: Identifier = 0
        var isGameDisabled: Bool { teams.count < 2 }
        
        // MARK: Settings
        var roundTime: Int
        var wordsForWin: Int
        var settings: [SettingItem] {
            SettingItem.allCases(interval: roundTime, words: wordsForWin)
        }
        
        // MARK: BS
        var isShowingImageSheet = false
        
        var isSheetsShowing: Bool {
            isShowingImageSheet
        }
    }
}
