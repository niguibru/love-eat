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
    var returnError: RepositoryError?
    
    var dishListCurrentValue = CurrentValueSubject<[Dish], RepositoryError>([])
    
    func refreshList() {
        if let returnError = returnError {
            dishListCurrentValue.send(completion: .failure(returnError))
            return
        }
        
        dishListCurrentValue.send([testDishes[0], testDishes[1]])
    }
    
    func add(_ dish: Dish) {}

}

class LoveEatTests: XCTestCase {

    let dishRepository = Mock_DishRepository()
    
    override func setUpWithError() throws {
        dishRepository.returnError = nil
    }
    
    func test_start_noDishes() throws {
        let sut = DishListViewModel(dishRepository: dishRepository)
        
        XCTAssertTrue(sut.dishes.count == 0)
    }

    func test_start_andGetDishesWithNoErrors_getTwoDishes() throws {
        let sut = DishListViewModel(dishRepository: dishRepository)
        
        sut.refreshWithAllDishes()
        RunLoop.main.run(mode: .default, before: .distantPast)
        
        XCTAssertTrue(sut.dishes.count == 2)
        XCTAssertTrue(sut.dishes[0].id == testDishes[0].id)
        XCTAssertTrue(sut.dishes[1].id == testDishes[1].id)
    }
    
    func test_start_andGetDishesWithUnknownError_getZeroDishesAndShowUnknownError() throws {
        dishRepository.returnError = RepositoryError.unknown
        let sut = DishListViewModel(dishRepository: dishRepository)
        
        sut.refreshWithAllDishes()
        RunLoop.main.run(mode: .default, before: .distantPast)
        
        XCTAssertTrue(sut.dishes.count == 0)
        XCTAssertTrue(sut.errorMessage == "Unknown error")
    }
    
    func test_start_andGetDishesWithServerError_getZeroDishesAndShowServerError() throws {
        dishRepository.returnError = RepositoryError.server
        let sut = DishListViewModel(dishRepository: dishRepository)
        
        sut.refreshWithAllDishes()
        RunLoop.main.run(mode: .default, before: .distantPast)
        
        XCTAssertTrue(sut.dishes.count == 0)
        XCTAssertTrue(sut.errorMessage == "Server error")
    }
    
    func test_start_andGetDishesWithDecodingErrors_getZeroDishesAndShowDecodingError() throws {
        dishRepository.returnError = RepositoryError.decoding
        let sut = DishListViewModel(dishRepository: dishRepository)
        
        sut.refreshWithAllDishes()
        RunLoop.main.run(mode: .default, before: .distantPast)
        
        XCTAssertTrue(sut.dishes.count == 0)
        XCTAssertTrue(sut.errorMessage == "Decoding error")
    }

}
