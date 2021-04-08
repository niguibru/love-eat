//
//  Dish.swift
//  LoveEat
//
//  Created by Nicolas Brucchieri on 29/03/2021.
//

import Foundation

struct Dish: Identifiable, Codable {
    var id = UUID()
    let name: String
    let image: String
    let stars: Float
    let minutes: Int
    let ingredients: [Ingredient]
    let steps: [String]
    
    enum CodingKeys: String, CodingKey {
        case name
        case image
        case stars
        case minutes
        case ingredients
        case steps
    }

    init(name: String, image: String, stars: Float, minutes: Int, ingredients: [Ingredient], steps: [String]) {
        self.name = name
        self.image = image
        self.stars = stars
        self.minutes = minutes
        self.ingredients = ingredients
        self.steps = steps
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        
        self.name = try values.decode(String.self, forKey: .name)
        self.image = try values.decode(String.self, forKey: .image)
        self.stars = try values.decode(Float.self, forKey: .stars)
        self.minutes = try values.decode(Int.self, forKey: .minutes)
        self.ingredients = try values.decode([Ingredient].self, forKey: .ingredients)
        self.steps = try values.decode([String].self, forKey: .steps)
    }
}


let testDishes: [Dish] = [
    Dish(name: "Mila napolitana con papas", image: "mila", stars: 3.5, minutes: 20, ingredients: [
        Ingredient(name: "Sliced steaks", quantity: "4 pieces"),
        Ingredient(name: "Eggs", quantity: "3"),
        Ingredient(name: "Bread crumbs", quantity: "2 cups"),
        Ingredient(name: "Tomato sauce", quantity: "1/2 cup"),
        Ingredient(name: "Deli ham", quantity: "4 slices"),
        Ingredient(name: "Mozzarella cheese", quantity: "20g"),
    ], steps: [
        "Gather the ingredients.",
        "Place the eggs in a shallow bowl or pan, and whisk them together with the oregano and some salt and pepper.",
        "Stir the parmesan cheese and garlic into the bread crumbs and place them in another shallow pan.",
        "Dip the steaks first in the egg mixture, then in the bread crumbs, coating them well with the crumbs.",
        "Heat the olive oil in a heavy skillet, and cook steaks for several minutes on each side, until golden brown and crispy. Drain steaks on paper towels.",
        "Place steaks on a baking sheet. Turn on oven broiler.",
        "Top each steak with a slice of ham, 2 to 3 tablespoons tomato sauce, and 1/4 cup grated mozzarella cheese. Sprinkle Italian seasoning over the cheese and place steaks under ​the broiler until cheese melts.",
        "Serve warm, with fries.",
        "Enjoy!"
    ]),
    Dish(name: "Croissant", image: "croissant", stars: 5, minutes: 180, ingredients: [
    ], steps: []),
    Dish(name: "Cheescake", image: "cheescake", stars: 5, minutes: 60, ingredients: [
    ], steps: []),
]

let testNewDish: Dish = Dish(
    name: "New Cheescake",
    image: "cheescake",
    stars: 5,
    minutes: 60,
    ingredients: [],
    steps: []
)
