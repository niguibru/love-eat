//
//  DishRepository.swift
//  LoveEat
//
//  Created by Nicolas Brucchieri on 30/03/2021.
//

import Foundation
import Combine

protocol DishRepository {
    // var dishListChanged: CurrentValueSubject<[Dish], RepositoryError> { get }
    func getAll() -> AnyPublisher<[Dish], RepositoryError>
    func add(_ dish: Dish)
}

protocol DishDynamicRepository {
    func startListeningForDishes() -> AnyPublisher<[Dish], RepositoryError>
}

enum RepositoryError: Error {
    case unknown
    case server
    case decoding
    
    var localizedDescription: String {
        switch self {
        case .unknown:
            return "Unknown error"
        case .server:
            return "Server error"
        case .decoding:
            return "Decoding error"
        }
    }
}

