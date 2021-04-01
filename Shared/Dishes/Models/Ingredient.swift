//
//  Ingredient.swift
//  LoveEat
//
//  Created by Nicolas Brucchieri on 30/03/2021.
//

import Foundation

struct Ingredient: Identifiable, Codable {
    var id = UUID()
    let name: String
    let quantity: String
    
    enum CodingKeys: String, CodingKey {
        case name
        case quantity
    }
    
    init(name: String, quantity: String) {
        self.name = name
        self.quantity = quantity
    }
    
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.name = try values.decode(String.self, forKey: .name)
        self.quantity = try values.decode(String.self, forKey: .quantity)
    }
    
}
