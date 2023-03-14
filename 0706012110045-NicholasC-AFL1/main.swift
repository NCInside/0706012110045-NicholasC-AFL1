//
//  main.swift
//  0706012110045-NicholasC-AFL1
//
//  Created by MacBook Pro on 03/03/23.
//

import Foundation

var start : String?
var name : String?
var go : String?
var usr_hp = 100
var mp = 50
var potion = 10
var elixir = 5

func containsOnlyLetters(input: String) -> Bool {
   for chr in input {
      if (!(chr >= "a" && chr <= "z") && !(chr >= "A" && chr <= "Z") ) {
         return false
      }
   }
   return true
}

func playerStats() {
    var input: String?
    repeat {
        print("""
    
    Player name: \(name!)

    HP: \(usr_hp)/100
    MP: \(mp)/50

    Magic:
    - Physical Attack. No mana required. Deal 5pt of damage.
    - Meteor. Use 15pt of MP. Deal 50pt of damage.
    - Shield. Use 10pt of MP. Block enemy's attack in 1 turn.

    Items:
    - Potion x\(potion). Heal 20pt of your HP.
    - Elixir x\(elixir). Add 10pt of your MP.

    Press [return] to go back:
    """, terminator: " ")
        input = readLine()
    } while (input != "")
}

func healWound() {
    var first = true
    repeat {
        var input: String?
        if (potion == 0) {
            repeat {
                print("""

            You don't have any potion left. Be careful of your next journey.
            Press [return] to go back:
            """, terminator: " ")
                input = readLine()
            } while (input != "")
            break
        }
        
        if (first) {
            first.toggle()
            print("""

        Your HP is \(usr_hp).
        You have \(potion) Potions.

        Are you sure want to use 1 potion to heal wound? [Y/N]
        """, terminator: " ")
            input = readLine()
        } else {
            print("""

        Your HP is now: \(usr_hp)
        You have \(potion) Potion left.

        Still want to use 1 potion to heal wound again? [Y/N]
        """, terminator: " ")
            input = readLine()
        }
        
        if (input?.lowercased() == "n") {
            break
        }
        else if (input?.lowercased() == "y"){
            potion -= 1
            usr_hp += (usr_hp <= 80) ? 20 : (100 - usr_hp)
        }
    } while (true)
}

func encounter(intro: String, enemy: String) {
    let quant = Int.random(in: 1...5)
    let ene_dmgs = (1...quant).map( {_ in Int.random(in: 1...10)} )
    var scanned = Array(repeating: false, count: quant)
    var ene_hps = (1...quant).map( {_ in Int.random(in: 500...800)} )
    var block = false
    var input: String?
    
    print(intro)
    
    repeat {
        
        let ene_slain = ene_hps.filter{$0 == 0}.count
        
        print("""

    😈 Name: \(enemy) x\(quant - ene_slain)
    😈 Health: \(scanned[ene_slain] ? String(ene_hps[ene_slain]) : "??")
    
    😩 Player's Health: \(usr_hp)/100

    Choose your action:
    [1] Physical Attack. No mana required. Deal 10-25pt of damage.
    [2] Meteor. Use 15pt of MP. Deal 50pt of damage.
    [3] Shield. Use 10pt of MP. Block enemy's attack in 1 turn.

    [4] Use Potion to heal wound.
    [5] Use Elixir to fill mana.
    [6] Scan enemy's vital
    [7] Flee from battle.

    Your choice?
    """, terminator: " ")
        input = readLine()
        
        if (input == "7") {
            break
        }
        else if (input == "6") {
            scanned[ene_slain] = true
            print("\nYou scan the enemy's vital!")
        }
        else if (input == "5") {
            if (elixir == 0) {
                print("\nYou don't have any elixir!")
            } else {
                elixir -= 1
                mp += (mp <= 40) ? 10 : (50 - mp)
                print("\nYou're filled with mana!")
            }
        }
        else if (input == "4") {
            if (potion == 0) {
                print("\nYou don't have any potion!")
            } else {
                potion -= 1
                usr_hp += (usr_hp <= 80) ? 20 : (100 - usr_hp)
                print("\nYou heal!")
            }
        }
        else if (input == "3") {
            if (mp >= 10) {
                mp -= 10
                block.toggle()
                print("\nYou block!")
            }
            else {
                print("\nYou don't have mana!")
            }
        }
        else if (input == "2") {
            if (mp >= 15) {
                mp -= 15
                ene_hps[ene_slain] -= (ene_hps[ene_slain] >= 50) ? 50 : ene_hps[ene_slain]
                print("\nYou use Meteor!")
            }
            else {
                print("\nYou don't have mana")
            }
        }
        else if (input == "1") {
            let usr_dmg = Int.random(in: 10...25)
            ene_hps[ene_slain] -= (ene_hps[ene_slain] >= usr_dmg) ? usr_dmg : ene_hps[ene_slain]
            print("\nYou attack!")
        }
        
        if (ene_hps[ene_slain] == 0 && ene_slain == quant) {
            print("\nYou slay the \(enemy)!")
            break
        }
        
        if (!block) {
            usr_hp -= ene_dmgs[ene_slain]
        } else {
            block.toggle()
        }
        
        if (usr_hp <= 0) {
            break
        }
        
    } while (true)
    if (input == "6") {
        flee()
    }
    
}

func flee() {
    var input: String?
    repeat {
        print("""
        
        You feel that if you don't escape soon, you won't be able to continue the fight.
        You look around frantically, searching for a way out. You sprint towards the exit, your heart pounding in your chest.
        
        You're safe, for now.
        Press [return] to continue:
        """, terminator: " ")
        input = readLine()
    } while (input != "")
}

func main() {
    repeat {
        print("""
        
        Welcome to the world of magic! 🧙🏿‍♂️🪄

        You have been chosen to embark on an epic journey as a young wizard on the path to becoming a master of the arcane arts. Your adventure will take you through forests 🌲, mountains ⛰️, and dungeons 🏰, where you will face challenges, make allies, and fight enemies.

        Press [return] to continue:
        """, terminator: " ")
        start = readLine()
    } while (start != "")

    repeat {
        print("\nMay I know your name, a young wizard?", terminator: " ")
        name = readLine()
    } while (
        !containsOnlyLetters(input: name ?? "1") || name == ""
    )
    print("\nNice to meet you \(name!)")

    repeat {
        
        if (usr_hp <= 0) {
            print("\nYou Died!")
            break
        }
        
        print("""

        From here, you can...

        [C]heck your health and stats
        [H]eal your wounds with potion

        ...or choose where you want to go

        [F]orest of Troll
        [M]ountain of Golem
        [Q]uit game

        Your choice?
        """, terminator: " ")
        go = readLine()
        let lowGo = go?.lowercased()
        if (lowGo == "c") {
            playerStats()
        }
        else if (lowGo == "h") {
            healWound()
        }
        else if (lowGo == "f") {
            encounter(intro: """
            
            As you make your way through the rugged mountain terrain, you can feel the chill of the wind biting at your skin.
            Suddenly, you hear a sound that makes you freeze in your tracks. That's when you see it - a massive, snarling Golem emerging from the shadows.
            """, enemy: "Troll")
        }
        else if (lowGo == "m") {
            encounter(intro: """

            As you make your way through the rugged mountain terrain, you can feel the chill of the wind biting at your skin.
            Suddenly, you hear a sound that makes you freeze in your tracks. That's when you see it - a massive, snarling Golem emerging from the shadows.
            """, enemy: "Golem")
        }
        else if (lowGo == "q") {
            break
        }
    } while (true)
}

main()
