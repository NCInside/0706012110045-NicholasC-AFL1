//
//  Enemy.swift
//  0706012110045-NicholasC-AFL1
//
//  Created by MacBook Pro on 30/03/23.
//

import Foundation

class Enemy: Character, Attack {
    typealias AttackTarget = User
    
    var scanned: Bool
    var drops: [Material]
    
    init(name: String, damage: Int, hp: Int, drops: Material...) {
        self.scanned = false
        self.drops = drops
        super.init(name: name, damage: damage, hp: hp)
    }
    
    func attack(_ target: User) -> Int {
        let damage = target.block ? 0 : self.damage
        target.hp -= damage
        return damage
    }
    
    func dropLoot() -> Material {
        return drops.randomElement()!
    }
    
}
