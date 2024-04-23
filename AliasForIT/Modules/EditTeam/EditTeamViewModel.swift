//
//  EditTeamViewModel.swift
//  AliasForIT
//
//  Created by Дмитрий Пантелеев on 20.12.2022.
//

import Foundation
import Combine

final class EditTeamViewModel: ObservableObject {
    
    // MARK: - Servives
    weak var router: MainRouter?
    
    // MARK: -
    let input: Input
    @Published var output: Output
    
    // MARK: - External
    let onSave: PassthroughSubject<Void, Never>
    
    // MARK: - Private variables
    private var isEdit: Bool
    private var cancellable = Set<AnyCancellable>()
    
    // MARK: - Initializer
    init(onSave: PassthroughSubject<Void, Never>, model: TeamModel? = nil, router: MainRouter?) {
        
        self.router = router
        
        self.input = Input()
        
        if let model = model {
            self.isEdit = true
            self.output = Output(id: model.id, name: model.name, image: model.image.rawValue)
        } else {
            self.isEdit = false
            self.output = Output()
        }
        
        self.onSave = onSave
        
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
        bindOnSave()
        bindImageTap()
    }
    
    func bindOnSave() {
        input.onSaveTap
            .combineLatest($output)
            .sink { _, output in
                
                self.router?.pop {
                    
                    let team = TeamModel(
                        id: output.id,
                        name: output.name,
                        image: TeamImage(rawValue: output.image) ?? .elon,
                        score: 0)
                    
//                    if self.isEdit {
//                        
//                        let index = TeamsStorage.shared.teams.firstIndex {
//                            $0.id == output.id
//                        }
//                        
//                        TeamsStorage.shared.teams.remove(at: index!)
//                        TeamsStorage.shared.teams.insert(team, at: index!)
//                        
//                    } else {
//                        TeamsStorage.shared.teams.append(team)
//                    }
                    
                    self.onSave.send()
                }
            }
            .store(in: &cancellable)
    }
    
    func bindImageTap() {
        input.onImageTap
            .sink { [weak self] image in  
                self?.output.isSelectedImage = image
                self?.output.image = image
            }
            .store(in: &cancellable)
    }
}

extension EditTeamViewModel {
    
    struct Input {
        let onSaveTap = PassthroughSubject<Void, Never>()
        let onImageTap = PassthroughSubject<String, Never>()
    }
    
    struct Output {
        var id: Int = UUID().hashValue
        var name: String = ""
        var image: String = ""
        
        var images: [String] = UserStorage.shared.defaultAvatars
        var isSelectedImage: String = ""
    }
}
