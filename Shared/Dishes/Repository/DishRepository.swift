//
//  DishRepository.swift
//  LoveEat
//
//  Created by Nicolas Brucchieri on 30/03/2021.
//

import Foundation
import Combine

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

class DishRepository {
        
    private let urlString = "https://raw.githubusercontent.com/niguibru/love-eat-json-examples/main/dishes.json"

    func getAll() -> AnyPublisher<[Dish], RepositoryError> {
        let request = URLRequest(url: URL(string: urlString)!)
        
        return URLSession.shared.dataTaskPublisher(for: request)
            .tryMap { response in
                guard
                  let httpURLResponse = response.response as? HTTPURLResponse,
                  httpURLResponse.statusCode == 200
                else {
                    throw RepositoryError.server
                }
                return response.data
            }
            .decode(type: [Dish].self, decoder: JSONDecoder())
            .mapError { error in
                switch error {
                case is Swift.DecodingError:
                    return RepositoryError.decoding
                case let repositoryError as RepositoryError:
                    return repositoryError
                default:
                    return RepositoryError.unknown
                }
            }
            .eraseToAnyPublisher()
    }
    
}
