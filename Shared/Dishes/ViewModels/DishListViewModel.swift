//
//  DishStore.swift
//  LoveEat
//
//  Created by Nicolas Brucchieri on 29/03/2021.
//

import Foundation
import Combine

class DishListViewModel: ObservableObject {
    @Published private (set) var dishes: [Dish] = []
    @Published private (set) var errorMessage: String?
    
    private let dishRepository: DishRepository
    
    private var cancellables: Set<AnyCancellable> = []
    
    init(dishRepository: DishRepository) {
        self.dishRepository = dishRepository
    }
    
    func refreshWithAllDishes() {
        dishRepository.dishListCurrentValue
            .receive(on: RunLoop.main)
            .sink(receiveCompletion: { [weak self] completion in
                switch completion {
                case .failure(let error):
                    // For now I'm just printing the error
                    print(error.localizedDescription)
                    self?.errorMessage = error.localizedDescription
                case .finished:
                    print("finished")
                    break
                }
            }, receiveValue: { [weak self] value in
                self?.dishes = value
            })
            .store(in: &cancellables)

        dishRepository.refreshList()
    }
    
    func add(dish: Dish) {
        dishRepository.add(dish)
    }
}
