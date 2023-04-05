//
//  Enemy.swift
//  0706012110045-NicholasC-AFL1
//
//  Created by MacBook Pro on 30/03/23.
//

import Foundation

class Enemy: Character {
    
    var scanned: Bool
    
    init(name: String, damage: Int, hp: Int, scanned: Bool = false) {
        self.scanned = scanned
        super.init(name: name, damage: damage, hp: hp)
    }
    
    func attackUser(user: User) -> Bool {
        if user.block {
            return false
        }
        user.hp -= damage
        return true
    }
    
}
