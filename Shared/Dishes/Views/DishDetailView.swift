//
//  DishDetailView.swift
//  LoveEat
//
//  Created by Nicolas Brucchieri on 29/03/2021.
//

import SwiftUI

struct DishDetailView: View {
    let dish: Dish
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .bottom) {
                Image(dish.image)
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(height: 190)
                    .clipped()
            
                DishBriefView(
                    title: dish.name,
                    stars: dish.stars,
                    minutes: dish.minutes
                )
                .offset(y: 25)
            }
            .padding(.bottom, 25)
                        
            DishIngredientsView(ingredients: dish.ingredients)
            
            DishStepsView(steps: dish.steps)
        }
        .navigationBarTitle("Dish", displayMode: .inline)
    }
}

struct DishDetailView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            DishDetailView(dish: testDishes.first!)
        }
    }
}
