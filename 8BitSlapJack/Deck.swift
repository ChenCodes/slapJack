//
//  Deck.swift
//  8BitSlapJack
//
//  Copyright (c) 2016 StrCat. All rights reserved.
//

import Darwin
import UIKit


// Project Euler #1 Solution in Swift


class Deck {
    let suits                  = ["Clubs", "Diamonds", "Hearts", "Spades"]
    let ranks                  = ["Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Jack", "Queen", "King", "Ace"]
    let totalCardCount         = 52
    var deck                   = [String]()
    var playerOneDeck          = [String]()
    var playerTwoDeck          = [String]()
    var mainPileDeck           = [String]()

    
    /**
     Initializing pile as a complete 52 card deck as a String Array.
     - Note: format: "Two of Clubs"
    */
    init() {
        for i in 0...(ranks.count - 1) {
            for j in 0...(suits.count - 1) {
                deck.append(ranks[i] + " of " + suits[j])
            }
        }
    }
    
    
    /**
      - Self explanatory, prints the deck.
    */

    func printDeck() {
        print(deck)
    }
    
    /**
        Distributes cards to player one and player two, determined by even/odd index.
        Each player will end up with 26 cards.
     */
    func giveCards() {
        for i in 0...51 {
            if i % 2 == 0 {
                playerOneDeck.append(deck[i])
            } else {
                playerTwoDeck.append(deck[i])
            }
        }
    }
    
    
    /**
     
     - parameters:
       - playerOneTurn: Will either be true or false, depending on if the current turn is player One's turn.
     - returns: Returns true when a card has successfully been drawn.
    */

    func flipCard(playerOneTurn: Bool) -> Bool {
        guard playerOneDeck.count != 0 else {
            return win(playerOneTurn)
        }
        guard playerTwoDeck.count != 0 else {
            return win(playerOneTurn)
        }
        
        if playerOneTurn {
            mainPileDeck.append(playerOneDeck.removeFirst())
        } else {
            mainPileDeck.append(playerTwoDeck.removeFirst())
        }

        return false

    }
    
    
    /**
     Presents the Winning Alert.
     - parameters:
        - playerOneTurn: the winning player
     - returns: Returns true that the game has completed
     */
    func win(playerOneTurn: Bool) -> Bool {
        let alert = UIAlertView()
        alert.title = "Congratulations!"
        alert.addButtonWithTitle("Done")
        
        if playerOneTurn {
            alert.message = "Player One Wins."
        } else {
            print("should come here")
            alert.message = "Player Two Wins."
        }
        
        alert.show()
        return true
    }
    
    
    
    /**
     This method is called when a player slaps the jack in the pile first.

 
     - parameters:
        - isPlayerOne: Value will be true if player One was
     */
    func addCardsToPlayersDeck(isPlayerOne: Bool) {
        if isPlayerOne {
            print("gave stuff to player 1")
            playerOneDeck += mainPileDeck
            mainPileDeck = []
        } else {
            print("gave stuff to player 2")
            playerTwoDeck += mainPileDeck
            mainPileDeck = []
        }
    }
    
    
    /**
     Shuffles the array of cards in the deck.
     */
    func shuffleDeck() {
        var tempArray = deck
        for index in 0...deck.count - 1 {
            let randomNumber = arc4random_uniform(UInt32(deck.count - 1))
            let randomIndex = Int(randomNumber)
            tempArray[randomIndex] = deck[index]
        }
        deck = tempArray
    }
    
    /**
     Player tries to slap a jack too early.  The Player must burn their card.  Their top card is sent to the bottom of the deck and their score decrements by 1
     - parameter isPlayer1: Bool whether or not player is Player 1
     */
    func burnCardFrom(isPlayer1: Bool) {
        if isPlayer1 {
            mainPileDeck.insert(playerOneDeck.removeFirst(), atIndex: 0)
        } else {
            mainPileDeck.insert(playerTwoDeck.removeFirst(), atIndex: 0)
        }
    }
}
