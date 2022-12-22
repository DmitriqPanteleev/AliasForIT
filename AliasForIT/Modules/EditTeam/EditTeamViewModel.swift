//
//  EditTeamViewModel.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 20.12.2022.
//

import Foundation
import Combine

final class EditTeamViewModel: ObservableObject {
    
    weak var router: MainRouter?
    
    let input: Input
    @Published var output: Output
    
    let saveChanges: PassthroughSubject<TeamModel, Never>
    
    private var cancellable = Set<AnyCancellable>()
    
    init(router: MainRouter?, model: TeamModel? = nil, saveChanges: PassthroughSubject<TeamModel, Never>) {
        self.router = router
        
        self.input = Input()
        
        if let model = model {
            self.output = Output(id: model.id, name: model.name, image: model.image)
        } else {
            self.output = Output()
        }
        
        self.saveChanges = saveChanges
        
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
        bindOnSave()
    }
    
    func bindOnSave() {
        input.onSave
            .sink {
                self.router?.pop {
                    self.saveChanges.send(TeamModel(id: self.output.id,
                                                    name: self.output.name,
                                                    image: self.output.image,
                                                    score: 0))
                }
            }
            .store(in: &cancellable)
    }
}

extension EditTeamViewModel {
    
    struct Input {
        let onSave = PassthroughSubject<Void, Never>()
    }
    
    struct Output {
        var id: Int = UUID().hashValue
        var name: String = ""
        var image: String = ""
    }
}
