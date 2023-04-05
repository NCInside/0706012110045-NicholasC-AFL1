//
//  main.swift
//  0706012110045-NicholasC-AFL1
//
//  Created by MacBook Pro on 03/03/23.
//

import Foundation

func main() {
    
    var input: String?
    
    repeat {
        print("""
        
        Welcome to the world of magic! 🧙🏿‍♂️🪄

        You have been chosen to embark on an epic journey as a young wizard on the path to becoming a master of the arcane arts. Your adventure will take you through forests 🌲, mountains ⛰️, and dungeons 🏰, where you will face challenges, make allies, and fight enemies.

        Press [return] to continue:
        """, terminator: " ")
        input = readLine()
    } while (input != "")
    
    input = nil
    var name: String?
    
    repeat {
        print("\nMay I know your name, a young wizard?", terminator: " ")
        name = readLine()
    } while (
        !containsOnlyLetters(input: name ?? "1") || name == ""
    )
    let user = User(name: name!, damage: 15, potion: 15, elixir: 12)
    print("\nNice to meet you \(user.name)")

    outerLoop: repeat {
        
        if (user.hp <= 0) {
            print("\nYou Died!")
            break
        }
        
        print("""

        From here, you can...

        [C]heck your health and stats
        [H]eal your wounds with potion
        [E]quip or craft items

        ...or choose where you want to go

        [F]orest of Troll
        [M]ountain of Golem
        [Q]uit game

        Your choice?
        """, terminator: " ")
        input = readLine()
        let lowerCaseInput = input?.lowercased()
        
        switch lowerCaseInput {
        case "c":
            playerStats()
        case "h":
            healWound()
        case "f":
            encounter(intro: """
            
            As you make your way through the rugged mountain terrain, you can feel the chill of the wind biting at your skin.
            Suddenly, you hear a sound that makes you freeze in your tracks. That's when you see it - a massive, snarling Golem emerging from the shadows.
            """, enemyName: "Troll")
        case "m":
            encounter(intro: """

            As you make your way through the rugged mountain terrain, you can feel the chill of the wind biting at your skin.
            Suddenly, you hear a sound that makes you freeze in your tracks. That's when you see it - a massive, snarling Golem emerging from the shadows.
            """, enemyName: "Golem")
        case "q":
            break outerLoop
        default:
            break
        }
        
    } while (true)
    
    
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
        
        Player name: \(user.name)

        HP: \(user.hp)/\(user.maxHp)
        MP: \(user.mp)/\(user.maxMp)

        Magic:
        - Physical Attack. No mana required. Deal \(user.damage < 6 ? String(user.damage) : "\(user.damage-5)-\(user.damage+5)")pt of damage.
        - Meteor. Use 15pt of MP. Deal 50pt of damage.
        - Shield. Use 10pt of MP. Block enemy's attack in 1 turn.

        Items:
        - Potion x\(user.potion). Heal \(user.potionHeal)pt of your HP.
        - Elixir x\(user.elixir). Add \(user.elixirHeal)pt of your MP.

        Press [return] to go back:
        """, terminator: " ")
            input = readLine()
        } while (input != "")
    }

    func healWound() {
        var first = true
        repeat {
            var input: String?
            if (user.potion == 0) {
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

            Your HP is \(user.hp).
            You have \(user.potion) Potions.

            Are you sure want to use 1 potion to heal wound? [Y/N]
            """, terminator: " ")
                input = readLine()
            } else {
                print("""

            Your HP is now: \(user.hp)
            You have \(user.potion) Potion left.

            Still want to use 1 potion to heal wound again? [Y/N]
            """, terminator: " ")
                input = readLine()
            }
            
            if (input?.lowercased() == "n") {
                break
            }
            else if (input?.lowercased() == "y"){
                user.usePotion()
            }
        } while (true)
    }

    func encounter(intro: String, enemyName: String) {
        let enemyQuantity = Int.random(in: 1...5)
        var input: String?
        var enemies: [Enemy] = []
        
        for _ in 1...enemyQuantity {
            enemies.append(Enemy(name: enemyName, damage: Int.random(in: 3...5), hp: Int.random(in: 300...500)))
        }
        
        print(intro)
        
        repeat {
            
            let enemySlain = enemies.filter { $0.hp <= 0 }.count
            let enemy = enemies[enemySlain]
            
            print("""

        😈 Enemy's Name: \(enemy.name) x\(enemyQuantity - enemySlain)
        😈 Enemy's Health: \(enemy.scanned ? String(enemy.hp) : "??")
        😈 Enemy's Damage: \(enemy.damage)
        
        😩 Player's Health: \(user.hp)/\(user.maxHp)
        😩 Player's Mana: \(user.mp)/\(user.maxMp)
        😩 Player's Potion: \(user.potion)
        😩 Player's Elixir: \(user.elixir)

        Choose your action:
        [1] Physical Attack. No mana required. Deal \(user.damage < 6 ? String(user.damage) : "\(user.damage-5)-\(user.damage+5)")pt of damage.
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
                flee()
                break
            }
            else if (input == "6") {
                enemy.scanned = true
                print("\nYou scan the enemy's vital!")
            }
            else if (input == "5") {
                if (user.elixir == 0) {
                    print("\nYou don't have any elixir!")
                } else {
                    user.useElixir()
                    print("\nYou're filled with mana!")
                }
            }
            else if (input == "4") {
                if (user.potion == 0) {
                    print("\nYou don't have any potion!")
                } else {
                    user.usePotion()
                    print("\nYou heal!")
                }
            }
            else if (input == "3") {
                if (user.shield(manaCost: 10)) {
                    print("\nYou use shield!")
                }
                else {
                    print("\nYou don't have mana!")
                }
            }
            else if (input == "2") {
                if (user.meteor(enemy: enemy, damage: 50, manaCost: 15)) {
                    print("\nYou use Meteor!")
                }
                else {
                    print("\nYou don't have mana")
                }
            }
            else if (input == "1") {
                let damage = user.attack(enemy)
                print("\nYou attack, you deal \(damage)pt of damage!")
            }
            else {
                print("\nYou fumbled!")
            }
            
            if (enemy.hp <= 0 && enemySlain == enemyQuantity - 1) {
                print("\nYou slay the \(enemy.name)!")
                break
            }
            
            let enemyDamage = enemy.attack(user)
            if (!user.block) {
                print("\nThe enemy attacks you for \(enemyDamage)pt of damage!")
            } else {
                user.block.toggle()
                print("\nYou block!")
            }
            
            if (user.hp <= 0) {
                break
            }
            
        } while (true)
        
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
    
}

main()
