//
//  DishGithubRepository.swift
//  LoveEat
//
//  Created by Nicolas Brucchieri on 02/04/2021.
//

import Foundation
import Combine

class DishGithubRepository: DishRepository {

    private let urlString = "https://raw.githubusercontent.com/niguibru/love-eat/master/dishes.json"

    func getAll() -> AnyPublisher<[Dish], RepositoryError> {
        let request = URLRequest(url: URL(string: urlString)!)
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { response in try DishGithubRepository.checkForServerError(response: response) }
            .decode(type: [Dish].self, decoder: JSONDecoder())
            .mapError { error in DishGithubRepository.mapErrors(error: error) }
            .eraseToAnyPublisher()
    }
    
    private static func mapErrors(error: Error) -> RepositoryError {
        switch error {
        case is Swift.DecodingError:
            return RepositoryError.decoding
        case let repositoryError as RepositoryError:
            return repositoryError
        default:
            return RepositoryError.unknown
        }
    }
    
    private static func checkForServerError(response: URLSession.DataTaskPublisher.Output) throws -> Data {
        guard
          let httpURLResponse = response.response as? HTTPURLResponse,
          httpURLResponse.statusCode == 200
        else {
            throw RepositoryError.server
        }
        return response.data
    }
    
    func add(_ dish: Dish) {
        // TODO: not implemented
    }
}
