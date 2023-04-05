//
//  User.swift
//  0706012110045-NicholasC-AFL1
//
//  Created by MacBook Pro on 30/03/23.
//

import Foundation

class User: Character, Attack {
    typealias AttackTarget = Enemy
    
    let maxHp: Int
    
    let maxMp: Int
    var mp: Int
    
    var potion: Int
    let potionHeal: Int
    
    var elixir: Int
    let elixirHeal: Int
    
    var block: Bool
    
    var materials: [Material] = []
    var items: [Item] = []
    
    var activeItem: Item?
    
    init(name: String, damage: Int, maxHp: Int = 100, maxMp: Int = 50, potion: Int, potionHeal: Int = 20, elixir: Int, elixirHeal: Int = 10, block: Bool = false) {
        self.maxHp = maxHp
        self.maxMp = maxMp
        self.mp = maxMp
        self.potion = potion
        self.potionHeal = potionHeal
        self.elixir = elixir
        self.elixirHeal = elixirHeal
        self.block = block
        super.init(name: name, damage: damage, hp: maxHp)
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
    
    func meteor(enemy: Enemy, damage: Int, manaCost: Int) -> Bool {
        if mp < manaCost {
            return false
        }
        mp -= manaCost
        enemy.hp -= damage
        return true
    }
    
    func attack(_ target: Enemy) -> Int {
        let damage = damage < 6 ? damage : Int.random(in: (damage-5)...(damage+5))
        target.hp -= damage
        return damage
    }
    
    func itemSpecial(enemy: Enemy) -> (Bool, String) {
        if mp < activeItem!.specialCost {
            return (false, activeItem!.specialPrompt)
        }
        mp -= activeItem!.specialCost
        enemy.hp -= activeItem!.specialDamage
        return (true, activeItem!.specialPrompt)
    }
    
    func craft(item: Item, ingredients: Material...) {
        var matching: [Int] = []
        for recipe in item.recipe {
            for ingredient in ingredients {
                if (Material.match(recipe: recipe, ingredient: ingredient)) {
                    matching.append(1)
                    break
                }
            }
        }
        if matching.count == item.recipe.count {
            items.append(item)
        }
    }
    
    func useMaterial(index: Int) {
        materials.remove(at: index)
    }
    
    func equip(item: Item) {
        activeItem = item
        damage += activeItem!.damageBoost
    }
    
    func dequip() {
        damage -= activeItem!.damageBoost
        activeItem = nil
    }
    
}
