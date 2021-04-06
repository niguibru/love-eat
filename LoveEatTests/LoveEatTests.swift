//
//  LoveEatTests.swift
//  LoveEatTests
//
//  Created by Nicolas Brucchieri on 31/03/2021.
//

import XCTest
import Combine
@testable import LoveEat

class Mock_DishRepository: DishRepository {
    func getAll() -> AnyPublisher<[Dish], RepositoryError> {
        return Just([testDishes[0], testDishes[1]])
            .setFailureType(to: RepositoryError.self)
            .eraseToAnyPublisher()
    }
}

class LoveEatTests: XCTestCase {

    func testExample() throws {
        let dishRepository = Mock_DishRepository()
        let dishListViewModel = DishListViewModel(dishRepository: dishRepository)

        XCTAssertTrue(dishListViewModel.dishes.count == 0)
        
        // Simulate new snapshot
        dishListViewModel.refreshWithAllDishes()
        RunLoop.main.run(mode: .default, before: .distantPast)
        XCTAssertTrue(dishListViewModel.dishes.count == 2)
        XCTAssertTrue(dishListViewModel.dishes[0].id == testDishes[0].id)
        XCTAssertTrue(dishListViewModel.dishes[1].id == testDishes[1].id)
    }

}
