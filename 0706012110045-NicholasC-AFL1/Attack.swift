//
//  Attack.swift
//  0706012110045-NicholasC-AFL1
//
//  Created by MacBook Pro on 06/04/23.
//

import Foundation

protocol Attack {
    associatedtype AttackTarget
    func attack(_ target: AttackTarget) -> Int
}
