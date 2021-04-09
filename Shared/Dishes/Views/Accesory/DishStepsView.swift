//
//  DishStepsView.swift
//  LoveEat
//
//  Created by Nicolas Brucchieri on 30/03/2021.
//

import SwiftUI

struct DishStepsView: View {
    let steps: [String]
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("Steps:")
                .font(.headline)
                .padding(.bottom, 8)
            
            ForEach(steps.indices) { i in
                Text("\(i + 1)- \(steps[i])")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding(.bottom, 4)
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding(.horizontal, 16)
    }
}


struct DishStepsView_Previews: PreviewProvider {
    static var previews: some View {
        DishStepsView(steps: testDishes.first!.steps)
    }
}
