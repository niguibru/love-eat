//
//  DishStore.swift
//  LoveEat
//
//  Created by Nicolas Brucchieri on 29/03/2021.
//

import Foundation
import Combine

protocol DishRepository {
    func getAll() -> AnyPublisher<[Dish], RepositoryError>
}
    
class DishListViewModel: ObservableObject {
    @Published private (set) var dishes: [Dish] = []
    @Published private (set) var errorMessage: String?
    
    private let dishRepository: DishRepository
    private var cancellables: Set<AnyCancellable> = []
    
    init(dishRepository: DishRepository, dishes: [Dish] = []) {
        self.dishRepository = dishRepository
        self.dishes = dishes
    }
    
    func getAll() {
        dishRepository.getAll()
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .finished:
                    break
                case .failure(let error):
                    // For now I'm just printing the error
                    print(error.localizedDescription)
                    self?.errorMessage = error.localizedDescription
                }
            }, receiveValue: { [weak self] value in
                self?.dishes = value
            })
            .store(in: &cancellables)
    }
}
