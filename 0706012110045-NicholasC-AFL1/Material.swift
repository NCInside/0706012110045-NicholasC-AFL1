//
//  Material.swift
//  0706012110045-NicholasC-AFL1
//
//  Created by MacBook Pro on 05/04/23.
//

import Foundation

struct Material: Equatable {
    
    let name: String
    let rating: Int
    
    func combine(material: Material) -> Material {
        var totalRating = 0
        if material.name != name {
            totalRating -= material.rating
        }
        else {
            totalRating += material.rating
        }
        return Material(name: name, rating: (totalRating <= -rating) ? 1 : (rating + totalRating) )
    }
    
    static func match(recipe: Material, ingredient: Material) -> Bool {
        return recipe.name == ingredient.name && recipe.rating <= ingredient.rating
    }
    
}
