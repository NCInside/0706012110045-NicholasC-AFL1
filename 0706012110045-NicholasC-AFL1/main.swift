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
var hp = 100
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

    HP: \(hp)/100
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

        Your HP is \(hp).
        You have \(potion) Potions.

        Are you sure want to use 1 potion to heal wound? [Y/N]
        """, terminator: " ")
            input = readLine()
        } else {
            print("""

        Your HP is now: \(hp)
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
            hp += (hp <= 80) ? 20 : 100 - hp
        }
    } while (true)
}

func forestOfTroll() {
    var quant = Int.random(in: 1...5)
    var dmg = 5
    var scanned = false
    var ene_hp = 1000
    var block = false
    var input: String?
    print("""

As you enter the forest, you feel a sense of unease wash over you.
Suddenly, you hear the sound of twigs snapping behind you. You quickly spin around, and find a Troll emerging from the shadows.
""")
    
    repeat {
        print("""

    😈 Name: Troll x\(quant)
    😈 Health: \(scanned ? String(ene_hp) : "??")

    Choose your action:
    [1] Physical Attack. No mana required. Deal 5pt of damage.
    [2] Meteor. Use 15pt of MP. Deal 50pt of damage.
    [3] Shield. Use 10pt of MP. Block enemy's attack in 1 turn.

    [4] Use Potion to heal wound.
    [5] Scan enemy's vital
    [6] Flee from battle.

    Your choice?
    """, terminator: " ")
        input = readLine()
        
        if (input == "6") {
            break
        }
        else if (input == "5") {
            scanned = true
        }
        else if (input == "4") {
            if (potion == 0) {
                print("\nYou don't have any potion!")
            } else {
                potion -= 1
                hp += (hp <= 80) ? 20 : 100 - hp
            }
        }
        else if (input == "3") {
            if (mp >= 10) {
                mp -= 10
                block.toggle()
            }
        }
        else if (input == "2") {
            if (mp >= 15) {
                mp -= 15
                ene_hp -= 50
            }
        }
        else if (input == "1") {
            ene_hp -= 5
        }
        
        
    } while (true)
    if (input == "6") {
        flee()
    }
}

func mountainOfGolem() {
    var quant = Int.random(in: 1...5)
    var dmg = 5
    var scanned = false
    var ene_hp = 1000
    var block = false
    var input: String?
    print("""

As you make your way through the rugged mountain terrain, you can feel the chill of the wind biting at your skin.
Suddenly, you hear a sound that makes you freeze in your tracks. That's when you see it - a massive, snarling Golem emerging from the shadows.
""")
    
    repeat {
        print("""

    😈 Name: Golem x1
    😈 Health: \(scanned ? String(ene_hp) : "??")

    Choose your action:
    [1] Physical Attack. No mana required. Deal 5pt of damage.
    [2] Meteor. Use 15pt of MP. Deal 50pt of damage.
    [3] Shield. Use 10pt of MP. Block enemy's attack in 1 turn.

    [4] Use Potion to heal wound.
    [5] Scan enemy's vital
    [6] Flee from battle.

    Your choice?
    """, terminator: " ")
        input = readLine()
        
        if (input == "6") {
            break
        }
        else if (input == "5") {
            scanned = true
        }
        else if (input == "4") {
            if (potion == 0) {
                print("\nYou don't have any potion!")
            } else {
                potion -= 1
                hp += (hp <= 80) ? 20 : 100 - hp
            }
        }
        else if (input == "3") {
            if (mp >= 10) {
                mp -= 10
                block.toggle()
            }
        }
        else if (input == "2") {
            if (mp >= 15) {
                mp -= 15
                ene_hp -= 50
            }
        }
        else if (input == "1") {
            ene_hp -= 5
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
        forestOfTroll()
    }
    else if (lowGo == "m") {
        mountainOfGolem()
    }
    else if (lowGo == "q") {
        break
    }
} while (true)
