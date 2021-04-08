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
            }
            .navigationTitle("Dishes")
            .toolbar {
                Button("Add") {
                    withAnimation{
                        viewModel.add(dish: testNewDish)
                    }
                }
            }
        }
        .accentColor(Color(red: 207/255, green: 172/255, blue: 73/255))
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear() {
            viewModel.refreshWithAllDishes()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        struct DishTestRepository: DishRepository {
            var dishList = Array(testDishes.prefix(2))
            var dishListCurrentValue = CurrentValueSubject<[Dish], RepositoryError>([])
            
            func refreshList() {
                dishListCurrentValue.send(dishList)
            }
            
            func add(_ dish: Dish) {
                dishListCurrentValue.value.append(dish)
            }
        }
        
        let viewModel = DishListViewModel(dishRepository: DishTestRepository())
        return DishListView(viewModel: viewModel)
    }
}
