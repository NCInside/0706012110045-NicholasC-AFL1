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
    var userName: String?
    
    repeat {
        print("\nMay I know your name, a young wizard?", terminator: " ")
        userName = readLine()
    } while (
        !containsOnlyLetters(input: userName ?? "1") || userName == ""
    )
    
    var userStatistics = ["hp": 100, "mp": 50, "potion": 15, "elixir": 12]
    print("\nNice to meet you \(userName!)")

    outerLoop: repeat {
        
        if (userStatistics["hp"]! <= 0) {
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
            """, enemy: "Troll")
        case "m":
            encounter(intro: """

            As you make your way through the rugged mountain terrain, you can feel the chill of the wind biting at your skin.
            Suddenly, you hear a sound that makes you freeze in your tracks. That's when you see it - a massive, snarling Golem emerging from the shadows.
            """, enemy: "Golem")
        case "q":
            break outerLoop
        default:
            break
        }
        
    } while (true)
    
    
    // Function to check if a string contains only alphabet and not nil
    func containsOnlyLetters(input: String) -> Bool {
       for chr in input {
          if (!(chr >= "a" && chr <= "z") && !(chr >= "A" && chr <= "Z") ) {
             return false
          }
       }
       return true
    }

    // Check stats screen, takes no input to only show user's statistics
    func playerStats() {
        var input: String?
        repeat {
            print("""
        
        Player name: \(userName!)

        HP: \(userStatistics["hp"]!)/100
        MP: \(userStatistics["mp"]!)/50

        Magic:
        - Physical Attack. No mana required. Deal 10-25pt of damage.
        - Meteor. Use 15pt of MP. Deal 50pt of damage.
        - Shield. Use 10pt of MP. Block enemy's attack in 1 turn.

        Items:
        - Potion x\(userStatistics["potion"]!). Heal 20pt of your HP.
        - Elixir x\(userStatistics["elixir"]!). Add 10pt of your MP.

        Press [return] to go back:
        """, terminator: " ")
            input = readLine()
        } while (input != "")
    }

    // Heal wound screen, take non-case sensitive y/n input to perform drink potion
    func healWound() {
        var first = true
        repeat {
            var input: String?
            if (userStatistics["potion"] == 0) {
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

            Your HP is \(userStatistics["hp"]!).
            You have \(userStatistics["potion"]!) Potions.

            Are you sure want to use 1 potion to heal wound? [Y/N]
            """, terminator: " ")
                input = readLine()
            } else {
                print("""

            Your HP is now: \(userStatistics["hp"]!)
            You have \(userStatistics["potion"]!) Potion left.

            Still want to use 1 potion to heal wound again? [Y/N]
            """, terminator: " ")
                input = readLine()
            }
            
            if (input?.lowercased() == "n") {
                break
            }
            else if (input?.lowercased() == "y"){
                userStatistics["potion"]! -= 1
                userStatistics["hp"]! += (userStatistics["hp"]! <= 80) ? 20 : (100 - userStatistics["hp"]!)
            }
        } while (true)
    }

    // Enemy encounter screen, takes a series of non-case input to perform logics
    func encounter(intro: String, enemy: String) {
        let enemyQuantity = Int.random(in: 1...5)
        let enemyDamages = (1...enemyQuantity).map( {_ in Int.random(in: 3...5)} )
        var enemyHps = (1...enemyQuantity).map( {_ in Int.random(in: 300...500)} )
        var isScanned = Array(repeating: false, count: enemyQuantity)
        
        var block = false
        var input: String?
        
        print(intro)
        
        repeat {
            
            let enemySlain = enemyHps.filter{$0 == 0}.count
            
            print("""

        😈 Enemy's Name: \(enemy) x\(enemyQuantity - enemySlain)
        😈 Enemy's Health: \(isScanned[enemySlain] ? String(enemyHps[enemySlain]) : "??")
        😈 Enemy's Damage: \(String(enemyDamages[enemySlain]))
        
        😩 Player's Health: \(userStatistics["hp"]!)/100
        😩 Player's Mana: \(userStatistics["mp"]!)/50
        😩 Player's Potion: \(userStatistics["potion"]!)
        😩 Player's Elixir: \(userStatistics["elixir"]!)

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
                flee()
                break
            }
            else if (input == "6") {
                isScanned[enemySlain] = true
                print("\nYou scan the enemy's vital!")
            }
            else if (input == "5") {
                if (userStatistics["elixir"] == 0) {
                    print("\nYou don't have any elixir!")
                } else {
                    userStatistics["elixir"]! -= 1
                    userStatistics["mp"]! += (userStatistics["mp"]! <= 40) ? 10 : (50 - userStatistics["mp"]!)
                    print("\nYou're filled with mana!")
                }
            }
            else if (input == "4") {
                if (userStatistics["potion"] == 0) {
                    print("\nYou don't have any potion!")
                } else {
                    userStatistics["potion"]! -= 1
                    userStatistics["hp"]! += (userStatistics["hp"]! <= 80) ? 20 : (100 - userStatistics["hp"]!)
                    print("\nYou heal!")
                }
            }
            else if (input == "3") {
                if (userStatistics["mp"]! >= 10) {
                    userStatistics["mp"]! -= 10
                    block.toggle()
                    print("\nYou use shield!")
                }
                else {
                    print("\nYou don't have mana!")
                }
            }
            else if (input == "2") {
                if (userStatistics["mp"]! >= 15) {
                    userStatistics["mp"]! -= 15
                    enemyHps[enemySlain] -= 50
                    print("\nYou use Meteor!")
                }
                else {
                    print("\nYou don't have mana")
                }
            }
            else if (input == "1") {
                let userDamage = Int.random(in: 10...25)
                enemyHps[enemySlain] -= userDamage
                print("\nYou attack!, you deal \(userDamage)pt of damage!")
            }
            else {
                print("\nYou fumbled!")
            }
            
            if (enemyHps[enemySlain] <= 0 && enemySlain == enemyQuantity - 1) {
                print("\nYou slay the \(enemy)!")
                break
            }
            
            if (!block) {
                userStatistics["hp"]! -= enemyDamages[enemySlain]
                print("\nThe enemy attacks you for \(enemyDamages[enemySlain])pt of damage!")
            } else {
                block.toggle()
                print("\nYou block!")
            }
            
            if (userStatistics["hp"]! <= 0) {
                break
            }
            
        } while (true)
        
    }

    // Flee screen, repeating print
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
