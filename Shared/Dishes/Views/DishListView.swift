//
//  ContentView.swift
//  Shared
//
//  Created by Nicolas Brucchieri on 28/03/2021.
//

import SwiftUI
import Combine

struct DishListView: View {
    @ObservedObject var viewModel: DishListViewModel
    
    var body: some View {
        return NavigationView {
            ScrollView {
                LazyVStack(spacing: 16) {
                    ForEach(viewModel.dishes) { dish in
                        NavigationLink(
                            destination: DishDetailView(dish: dish)
                        ) {
                            DishCardView(dish: dish)
                        }
                        .buttonStyle(PlainButtonStyle())
                    }
                }
                .accessibility(identifier: "dish-list")
            }
            .navigationTitle("Dishes")
        }
        .accentColor(Color(red: 207/255, green: 172/255, blue: 73/255))
        .onAppear() {
            viewModel.getAll()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        struct DishTestRepository: DishRepository {
            func getAll() -> AnyPublisher<[Dish], RepositoryError> {
                return Just(testDishes)
                    .setFailureType(to: RepositoryError.self)
                    .eraseToAnyPublisher()
            }
        }
        
        let viewModel = DishListViewModel(dishRepository: DishTestRepository(), dishes: testDishes)
        return DishListView(viewModel: viewModel)
    }
}
