//
//  GameViewModel.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 03.12.2022.
//

import Foundation
import Combine

final class GameViewModel: ObservableObject {
    
    // MARK: - Services
    private let settingsManager: GameConfigurable
    private weak var router: RoundRouter?
    
    // MARK: - External
    let teams: [TeamModel]
    let onRoundFinish: PassthroughSubject<Int, Never>
    
    // MARK: - Internal variables
    private var currentTeamIndex: Int
    private var pointsLeft: [Int]
    private var cancellable = Set<AnyCancellable>()
    
    // MARK: - Connection with view
    let input: Input
    @Published var output: Output
    
    // MARK: - Initializer
    init(teams: [TeamModel], 
         settingsManager: GameConfigurable,
         onRoundFinish: PassthroughSubject<Int, Never>,
         router: RoundRouter?)
    {
        self.settingsManager = settingsManager
        self.router = router
        
        self.currentTeamIndex = 0
        self.teams = teams
        
        self.onRoundFinish = onRoundFinish
        
        self.pointsLeft = Array.init(repeating: settingsManager.pointsForWin,
                                     count: self.teams.count)
        
        self.input = Input()
        self.output = Output(pointsLeft: settingsManager.pointsForWin)
        
        setupBindings()
    }
    
    // MARK: - Deinitializer
    deinit {
    #if DEBUG
        print("\(self) DEINITED!!!")
    #endif
        
        cancellable.forEach { $0.cancel() }
        cancellable.removeAll()
    }
    
    // MARK: - Setup all bindings
    func setupBindings() {
        
        output.teams = self.teams
        output.currentTeam = self.teams[currentTeamIndex]
        
        bindRoundFinish()
        bindPlayTap()
        bindStopTap()
    }
    
    func bindRoundFinish() {
        self.onRoundFinish
            .handleEvents(receiveOutput: { [weak self] newScore in
                guard let self = self else { return }
                self.output.currentTeam?.score += newScore
                self.output.teams[self.currentTeamIndex].score += newScore
                
                self.pointsLeft[self.currentTeamIndex] -= self.output.currentTeam!.score
                self.output.pointsLeft = self.currentTeamIndex == self.teams.count - 1 ? self.pointsLeft[0] : self.pointsLeft[self.currentTeamIndex + 1]
                
                self.currentTeamIndex = self.currentTeamIndex == self.teams.count - 1 ? 0 : self.currentTeamIndex + 1
                self.output.currentTeam = self.teams[self.currentTeamIndex]
            })
            .sink { [weak self] newScore in
                self?.input.onAppear.send()
            }
            .store(in: &cancellable)
    }
    
    func bindPlayTap() {
        input.onPlayTap
            .sink { [weak self] in
                
                guard let self = self else { return }
                
                if self.output.pointsLeft > 0 {
                    
                    let roundModel = RoundModel(team: self.output.currentTeam!,
                                                words: WordsStorage.getRoundWords(count: self.settingsManager.pointsForWin),
                                                roundDuration: self.settingsManager.roundTime)
                    
                    self.router?.moveToRound(model: roundModel)
                }
            }
            .store(in: &cancellable)
    }
    
    func bindStopTap() {
        input.onStopTap
            .sink {
                self.router?.exit()
            }
            .store(in: &cancellable)
    }
    
    struct Input {
        let onAppear = PassthroughSubject<Void, Never>()
        let onPlayTap = PassthroughSubject<Void, Never>()
        let onStopTap = PassthroughSubject<Void, Never>()
    }
    
    struct Output {
        var teams: [TeamModel] = []
        var currentTeam: TeamModel? = nil
        var pointsLeft: Int
    }
}
