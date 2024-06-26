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
        bindSettings()
        bindTransitions()
        bindTeamControls()
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
        input.updateTeam
            .filter { $0.type == .adding }
            .map {
                TeamModel(name: $0.name, image: $0.image)
            }
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
                
                guard self.output.selectedTeamId > 0 else { return }
                self.output.selectedTeamId -= 1
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
        
        input.updateTeam
            .filter { $0.type == .editing }
            .map { $0.image }
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
            .filter { $0 != .rules }
            .sink { [weak self] setting in
                self?.output.settingSheetConfig.setting = setting
                self?.output.settingSheetConfig.isShowing = true
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
                self?.output.teamSheetConfig.type = .editing
                self?.output.teamSheetConfig.isShowing = true
            }
            .store(in: &cancellable)
        
        input.toAppendTeam
            .sink { [weak self] in
                self?.output.teamSheetConfig.type = .adding
                self?.output.teamSheetConfig.isShowing = true
            }
            .store(in: &cancellable)
    }
    
    func bindSettings() {
        input.confirmSetting
            .sink { [weak self] setting in
                switch setting {
                case .timeInterval(let value):
                    self?.output.roundTime = value
                case .wordsForWin(let value):
                    self?.output.wordsForWin = value
                case .rules:
                    break
                }
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
        let toAppendTeam = VoidSubject()
        let toChooseImage = VoidSubject()
        let confirmSetting = SettingSubject()
        
        // MARK: Teams Operations
        let updateTeam = TeamSheetSubject()
        let deleteTeam = VoidSubject()
        let editTeamName = StringSubject()
    }
    
    struct Output {
        // MARK: States
        var teams: [TeamModel] = []
        var selectedTeamId: Identifier = 0
        var isGameDisabled: Bool { teams.count < 2 }
        
        // MARK: Settings
        var settings: [SettingItem] = SettingItem.allCases(interval: 30, words: 30)
        var roundTime: Int {
            didSet {
                settings = SettingItem.allCases(interval: roundTime, words: wordsForWin)
            }
        }
        var wordsForWin: Int {
            didSet {
                settings = SettingItem.allCases(interval: roundTime, words: wordsForWin)
            }
        }
        
        // MARK: BS
        var teamSheetConfig = TypedTeamSheet(type: .adding, isShowing: false)
        var settingSheetConfig = SettingSheet(setting: .rules, isShowing: false)
        var isSheetsShowing: Bool {
            teamSheetConfig.isShowing || settingSheetConfig.isShowing
        }
    }
}

extension MainViewModel {
    struct SettingSheet {
        var setting: SettingItem
        var isShowing: Bool
    }
    
    struct TypedTeamSheet {
        var type: TeamSheetType
        var isShowing: Bool
    }
}
