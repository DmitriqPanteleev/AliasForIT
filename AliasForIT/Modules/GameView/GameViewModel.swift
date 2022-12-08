//
//  GameViewModel.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 03.12.2022.
//

import Foundation
import Combine

final class GameViewModel: ObservableObject {
    
    let teams: [TeamModel]
    
    private var currentTeamIndex: Int
    private var pointsLeft: [Int] = []
    
    let input: Input
    @Published var output: Output
    
    
    private var cancellable = Set<AnyCancellable>()
    
    init(teams: [TeamModel]) {
        
        self.currentTeamIndex = 0
        self.teams = teams
        
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
    }
    
    // TODO: trigger this func in RoundViewModel (on timer ends)
    func bindRoundFinish() {
        input.onRoundFinish
            .sink { [weak self] newScore in
                
                guard let self = self else { return }
                
                self.output.currentTeam?.score += newScore
                
                self.pointsLeft[self.currentTeamIndex] -= self.output.currentTeam!.score
                self.output.pointsLeft = self.pointsLeft[self.currentTeamIndex]
                
                self.currentTeamIndex += self.currentTeamIndex == self.teams.count - 1 ? 1 : -self.teams.count + 1
                self.output.currentTeam = self.teams[self.currentTeamIndex]
                
                self.input.onAppear.send()
            }
            .store(in: &cancellable)
    }
    
    
    struct Input {
        
        let onAppear = PassthroughSubject<Void, Never>()
        let onRoundFinish = PassthroughSubject<Int, Never>()
    }
    
    struct Output {
        var teams: [TeamModel] = []
        var currentTeam: TeamModel? = nil
        var pointsLeft: Int = 0
    }
}
