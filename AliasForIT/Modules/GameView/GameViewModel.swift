//
//  GameViewModel.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 03.12.2022.
//

import Foundation
import Combine

final class GameViewModel: ObservableObject {
    
    private weak var router: RoundRouter?
    
    let teams: [TeamModel]
    let onRoundFinish: PassthroughSubject<Int, Never>
    
    private var currentTeamIndex: Int
    private var pointsLeft: [Int]
    
    let input: Input
    @Published var output: Output
    
    
    private var cancellable = Set<AnyCancellable>()
    
    init(teams: [TeamModel], onRoundFinish: PassthroughSubject<Int, Never>, router: RoundRouter?) {
        
        self.currentTeamIndex = 0
        
        self.teams = teams
        self.router = router
        self.onRoundFinish = onRoundFinish
        
        self.pointsLeft = Array.init(repeating: UserStorage.shared.pointsForWin, count: self.teams.count)
        
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
        
        output.teams = self.teams
        output.currentTeam = self.teams[currentTeamIndex]
        
        bindRoundFinish()
        bindPlayTap()
    }
    
    // TODO: trigger this func in RoundViewModel (on timer ends)
    func bindRoundFinish() {
        self.onRoundFinish
            .sink { [weak self] newScore in
                
                guard let self = self else { return }
                
                // Хардкод
                // Слишком много операций
                //TODO: оптимизировать
                self.output.currentTeam?.score += newScore
                self.output.teams[self.currentTeamIndex].score += newScore
                
                self.pointsLeft[self.currentTeamIndex] -= self.output.currentTeam!.score
                self.output.pointsLeft = self.currentTeamIndex == self.teams.count - 1 ? self.pointsLeft[0] : self.pointsLeft[self.currentTeamIndex + 1]
                
                self.currentTeamIndex = self.currentTeamIndex == self.teams.count - 1 ? 1 : self.currentTeamIndex + 1
                self.output.currentTeam = self.teams[self.currentTeamIndex]
                
                self.input.onAppear.send()
            }
            .store(in: &cancellable)
    }
    
    func bindPlayTap() {
        input.onPlayTap
            .sink { [weak self] in
                guard let self = self else { return }
                
                // Хардкод
                let roundModel = RoundModel(team: self.output.currentTeam!, words: WordsStorage.getRoundWords(count: UserStorage.shared.roundTime), roundDuration: 10)
                
                self.router?.moveToRound(model: roundModel)
            }
            .store(in: &cancellable)
    }
    
    struct Input {
        
        let onAppear = PassthroughSubject<Void, Never>()
        let onPlayTap = PassthroughSubject<Void, Never>()
    }
    
    struct Output {
        var teams: [TeamModel] = []
        var currentTeam: TeamModel? = nil
        var pointsLeft: Int = UserStorage.shared.pointsForWin
    }
}
