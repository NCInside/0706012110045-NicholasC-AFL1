//
//  User.swift
//  0706012110045-NicholasC-AFL1
//
//  Created by MacBook Pro on 30/03/23.
//

import Foundation

class User {
    
    let name: String
    
    let maxHp: Int
    var hp: Int
    
    let maxMp: Int
    var mp: Int
    
    var potion: Int
    let potionHeal: Int
    
    var elixir: Int
    let elixirHeal: Int
    
    var block: Bool
    
    init(name: String, maxHp: Int = 100, maxMp: Int = 50, potion: Int, potionHeal: Int = 20, elixir: Int, elixirHeal: Int = 10, block: Bool = false) {
        self.name = name
        self.maxHp = maxHp
        self.hp = maxHp
        self.maxMp = maxMp
        self.mp = maxMp
        self.potion = potion
        self.potionHeal = potionHeal
        self.elixir = elixir
        self.elixirHeal = elixirHeal
        self.block = block
    }
    
    func usePotion() {
        potion -= 1
        hp += (hp <= (maxHp - potionHeal)) ? potionHeal : (maxHp - hp)
    }
    
    func useElixir() {
        elixir -= 1
        mp += (mp <= (maxMp - elixirHeal)) ? elixirHeal : (maxMp - mp)
    }
    
    func shield(manaCost: Int) -> Bool {
        if mp < manaCost {
            return false
        }
        block = true
        return true
    }
    
    func scan(enemy: Enemy) {
        enemy.scanned = true
    }
    
    func attack(enemy: Enemy, minDamage: Int, maxDamage: Int) -> Int {
        let damage = Int.random(in: minDamage...maxDamage)
        enemy.hp -= damage
        return damage
    }
    
    func meteor(enemy: Enemy, damage: Int, manaCost: Int) -> Bool {
        if mp < manaCost {
            return false
        }
        mp -= manaCost
        enemy.hp -= damage
        return true
    }
    
}
