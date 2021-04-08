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
    var dishListCurrentValue = CurrentValueSubject<[Dish], RepositoryError>([])

    private let path = "dishes"
    private let firestore: Firestore
    
    private var isListeningForUpdates = false
    
    init(firestore: Firestore = Firestore.firestore()) {
        self.firestore = firestore
    }
    
    func refreshList() {
        if !isListeningForUpdates { startListeningForUpdates() }
    }

    private func startListeningForUpdates() {
        firestore.collection(path).addSnapshotListener { [weak self] (snapshot, error) in
            if let error = error {
                print(error)
            }
            
            if let items = snapshot?.documents.compactMap({ try? $0.data(as: Dish.self) }) {
                self?.dishListCurrentValue.send(items)
            } else {
                self?.dishListCurrentValue.send([])
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
