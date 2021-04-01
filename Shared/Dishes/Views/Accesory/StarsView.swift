//
//  StarsView.swift
//  LoveEat
//
//  Created by Nicolas Brucchieri on 29/03/2021.
//

import SwiftUI

struct StarsView: View {
    private let maxStars: Float = 5
    let stars: Float
    var fullStars: Int {
        if stars < 0 { return 0 }
        return maxStars > stars ? Int(stars) : Int(maxStars)
    }
    var emptyStars: Int {
        if stars < 0 { return Int(maxStars) }
        return maxStars > stars ? Int(5 - stars) : 0
    }
    var halfStars: Int {
        if stars < 0 { return 0 }
        return maxStars > stars ? ((Float(fullStars + emptyStars) < 5) ? 1 : 0) : 0
    }
    
    var body: some View {
        HStack {
            ForEach(0..<fullStars) { _ in
                Image(systemName: "star.fill")
            }
            ForEach(0..<halfStars) { _ in
                Image(systemName: "star.leadinghalf.fill")
            }
            ForEach(0..<emptyStars) { _ in
                Image(systemName: "star")
            }
        }
        .foregroundColor(.yellow)
    }
}

struct StarsView_Previews: PreviewProvider {
    static var previews: some View {
        StarsView(stars: 3.5)
    }
}
