//
//  SwiftUIView.swift
//  LoveEat
//
//  Created by Nicolas Brucchieri on 30/03/2021.
//

import SwiftUI

struct DishIngredientsView: View {
    let ingredients: [Ingredient]
    
    var body: some View {
        VStack(alignment: .leading) {

            Text("Ingredients:")
                .font(.headline)
                .padding(.top, 8)
                .padding(.vertical, 8)
                .padding(.horizontal, 16)
            
            VStack {
                ForEach(ingredients) { ingredient in
                    HStack {
                        Text(ingredient.name)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .padding(.horizontal, 24)
                        Spacer()
                        Text(ingredient.quantity)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                            .padding(.trailing, 16)
                    }
                    
                    Rectangle()
                        .fill(Color.gray)
                        .opacity(0.3)
                        .frame(height: 1)
                        .padding(.leading, 24)
                        .padding(.trailing, 16)
                        .offset(y: -5)
                }
            }
            .padding(.bottom, 8)
        }
        .background(Color.white)
        .cornerRadius(20)
        .padding(16)
        .shadow(radius: 4)
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        DishIngredientsView(ingredients: testDishes.first!.ingredients)
    }
}
