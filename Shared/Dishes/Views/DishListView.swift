//
//  ContentView.swift
//  Shared
//
//  Created by Nicolas Brucchieri on 28/03/2021.
//

import SwiftUI

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
        }
        .accentColor(Color(red: 207/255, green: 172/255, blue: 73/255))
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear() {
            viewModel.getAll()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        let viewModel = DishListViewModel(dishes: testDishes)
        return DishListView(viewModel: viewModel)
    }
}
