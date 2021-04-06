//
//  DishFirebaseRepository.swift
//  LoveEat
//
//  Created by Nicolas Brucchieri on 02/04/2021.
//

import Foundation
import Combine
import FirebaseFirestore
import FirebaseFirestoreSwift

final class DishFirebaseRepository: DishRepository {

    private let path = "dishes"
    private let firestore: Firestore
    
    private var dishListChanged = CurrentValueSubject<[Dish], RepositoryError>([])
    private var isListeningForUpdates = false
    
    init(firestore: Firestore = Firestore.firestore()) {
        self.firestore = firestore
    }
    
    func getAll() -> AnyPublisher<[Dish], RepositoryError> {
        if !isListeningForUpdates { startListeningForUpdates() }
        return dishListChanged.eraseToAnyPublisher()
    }

    private func startListeningForUpdates() {
        firestore.collection(path).addSnapshotListener { [weak self] (snapshot, error) in
            if let error = error {
                print(error)
            }
            
            if let items = snapshot?.documents.compactMap({ try? $0.data(as: Dish.self) }) {
                self?.dishListChanged.send(items)
            } else {
                self?.dishListChanged.send([])
            }
        }
        isListeningForUpdates = true
    }
    
    func add(_ dish: Dish) {
        do {
            _ = try firestore.collection(path).addDocument(from: dish)
        } catch {
            print("Failed adding dish \(dish.name)")
        }
    }
}
