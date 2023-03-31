//
//  Entity.swift
//  0706012110045-NicholasC-AFL1
//
//  Created by MacBook Pro on 31/03/23.
//

import Foundation

class Entity {
    
    let name: String
    let damage: Int
    var hp: Int
    
    init(name: String, damage: Int, hp: Int) {
        self.name = name
        self.damage = damage
        self.hp = hp
    }
    
}
