//
//  Enemy.swift
//  0706012110045-NicholasC-AFL1
//
//  Created by MacBook Pro on 30/03/23.
//

import Foundation

class Enemy {
    
    let name: String
    let damage: Int
    var hp: Int
    var scanned: Bool
    
    init(name: String, damage: Int, hp: Int, scanned: Bool = false) {
        self.name = name
        self.damage = damage
        self.hp = hp
        self.scanned = scanned
    }
    
    func attack(user: User) -> Bool {
        if user.block {
            return false
        }
        user.hp -= damage
        return true
    }
    
}
