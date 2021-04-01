//
//  DishCardView.swift
//  LoveEat
//
//  Created by Nicolas Brucchieri on 29/03/2021.
//

import SwiftUI

struct DishCardView: View {
    let dish: Dish
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Image(dish.image)
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(height: 162)
                .clipped()
                .cornerRadius(20)
                .shadow(radius: 4)
                .padding(.horizontal, 16)
                
            DishBriefView(
                title: dish.name,
                stars: dish.stars,
                minutes: dish.minutes
            )
                .offset(y: 25)
        }
        .padding(.bottom, 25)
    }
}

struct DishCardView_Previews: PreviewProvider {
    static var previews: some View {
        DishCardView(dish: testDishes.first!)
    }
}
