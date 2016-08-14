//
//  Deck.swift
//  8BitSlapJack
//
//  Created by Jack Chen on 7/31/16.
//  Copyright © 2016 Jack Chen. All rights reserved.
//

import Darwin
import UIKit


// Project Euler #1 Solution in Swift

class Deck {
    let suits:[String]
    var ranks = [String]()
    let totalCardCount = 52
    var deck: [String] = []
    
    var playerOneDeck:[String] = []
    var playerTwoDeck:[String] = []
    var mainPileDeck: [String] = []
    //Initialize our deck
    //Bug I found: to declare array, need to do:
    
    init() {
        suits = ["Clubs", "Diamonds", "Hearts", "Spades"]
        ranks = ["Two", "Three", "Four", "Five", "Six", "Seven", "Eight", "Nine", "Ten", "Jack", "Queen", "King", "Ace"]
        for i in 0...(ranks.count - 1) {
            for j in 0...(suits.count - 1) {
                print(i)
                print(j)
                deck.append(ranks[i] + " of " + suits[j])
            }
        }
    }
    
    
    /*
     - Self explanatory, prints the deck.
     */
    
    func printDeck() {
        print(deck)
    }
    
    /*
     Information: Distributes cards to player one and player two, determined by even/odd index.
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
    func drawCard(playerOneTurn: Bool) -> Bool {
        //The idea here is to remove
        
        if playerOneTurn && playerOneDeck.count == 0 {
            
            let alert = UIAlertView()
            alert.title = "Congratulations!"
            alert.message = "Player Two Wins."
            alert.addButtonWithTitle("Done")
            alert.show()
            return true
            
        } else if !playerOneTurn && playerTwoDeck.count == 0 {
            let alert = UIAlertView()
            alert.title = "Congratulations!"
            alert.message = "Player One Wins."
            alert.addButtonWithTitle("Done")
            alert.show()
            return true
            
        } else {
            if playerOneTurn {
                mainPileDeck.append(playerOneDeck.removeFirst())
            } else {
                mainPileDeck.append(playerTwoDeck.removeFirst())
            }
            
            return false
        }
    }
    
    
    
    /**
     This method is called when a player slaps the jack in the pile first.
     
     - parameters:
     - isPlayerOne: Value will be true if player One was the one that slapped first.
     */
    func winningPlayer(isPlayerOne: Bool) {
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
    
    func shuffleArray() {
        var tempArray = deck
        for index in 0...deck.count - 1 {
            let randomNumber = arc4random_uniform(UInt32(deck.count - 1))
            let randomIndex = Int(randomNumber)
            tempArray[randomIndex] = deck[index]
        }
        deck = tempArray
    }
}















