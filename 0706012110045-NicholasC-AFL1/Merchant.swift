//
//  Merchant.swift
//  0706012110045-NicholasC-AFL1
//
//  Created by MacBook Pro on 06/04/23.
//

import Foundation

struct Merchant: Attack {
    typealias AttackTarget = User
    
    let potionConversion: Int
    let elixirConversion: Int
    let materialForPotion: [String]
    let materialForElixir: [String]
    
    func tradeForPotion(index: Int, user: User) -> Int {
        var material = user.materials[index]
        if (materialForPotion.contains(material.name)) {
            let potion = material.rating * potionConversion
            user.potion += potion
            material = user.useMaterial(index: index)
            return potion
        }
        return 0
    }
    
    func tradeForElixir(index: Int, user: User) -> Int {
        var material = user.materials[index]
        if (materialForElixir.contains(material.name)) {
            let elixir = material.rating * elixirConversion
            user.elixir += elixir
            material = user.useMaterial(index: index)
            return elixir
        }
        return 0
    }
    
    func attack(_ target: User) -> Int {
        let damage = Int.random(in: 100...999)
        target.hp -= damage
        return damage
    }
}
