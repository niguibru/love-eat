//
//  DishBriefView.swift
//  LoveEat
//
//  Created by Nicolas Brucchieri on 29/03/2021.
//

import SwiftUI

struct DishBriefView: View {
    let title: String
    let stars: Float
    let minutes: Int
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text(title)
                .font(.subheadline)
                .bold()
                .lineLimit(1)
                .padding(.vertical, 8)
            
            HStack {
                StarsView(stars: stars)
                Spacer()
                TimeView(minutes: minutes)
            }
            .font(.footnote)
            .foregroundColor(.secondary)
            .padding(.bottom, 8)
        }
        .padding(.horizontal, 8)
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 4)
        .frame(width: 240)
    }
}


struct DishBriefView_Previews: PreviewProvider {
    static var previews: some View {
        DishBriefView(
            title: testDishes.first!.name,
            stars: testDishes.first!.stars,
            minutes: testDishes.first!.minutes
        )
    }
}

struct TimeView: View {
    let minutes: Int
    
    var body: some View {
        HStack {
            Image(systemName: "timer")
            Text("\(minutes) min")
                .bold()
                .lineLimit(1)
        }
    }
}
