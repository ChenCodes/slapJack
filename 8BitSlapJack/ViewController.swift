//
//  ViewController.swift
//  8BitSlapJack
//
//  Created by Jack Chen on 7/7/16.
//  Copyright © 2016 Jack Chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var playerOneCardCount: UILabel!
    @IBOutlet weak var playerTwoCardCount: UILabel!
    @IBOutlet weak var playerTwoTextLabel: UILabel!
    @IBOutlet weak var pileOfCards: UIImageView!
    @IBOutlet weak var pileOfCardsCount: UILabel!
    @IBOutlet weak var playerTwoDeckImage: UIImageView!
    
    @IBOutlet weak var playerOneSwiped: UIButton!
    @IBOutlet weak var playerTwoSwiped: UIButton!
    
    var newDeck = Deck()
    var currentTurn = "1"
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        playerTwoCardCount.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
        playerTwoTextLabel.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
        playerTwoDeckImage.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))

        let swipeButtonUp: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "buttonUp")
        let swipeButtonDown: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "buttonDown")
        swipeButtonUp.direction = UISwipeGestureRecognizerDirection.Up
        swipeButtonDown.direction = UISwipeGestureRecognizerDirection.Down
        
        self.playerOneSwiped.addGestureRecognizer(swipeButtonUp)
        self.playerTwoSwiped.addGestureRecognizer(swipeButtonDown)
        
        newGame()
    }
    
    func newGame() {
        newDeck = Deck()
        newDeck.shuffleArray()
        newDeck.giveCards()
        
        playerOneCardCount.text = String(newDeck.playerOneDeck.count)
        playerTwoCardCount.text = String(newDeck.playerTwoDeck.count)
    }
    

    func buttonUp() {
        if currentTurn == "1" {
            
            if playerOneCardCount == 0 {
                print("game is over!")
                newGame()
            } else {
                print("i just swiped a card into the deck from player one's hand")
                //            print(newDeck.mainPile)
                if (!newDeck.drawCard("1")) {
                    playerOneCardCount.text = String(newDeck.playerOneDeck.count)
                    pileOfCards.image = UIImage(named: "\(newDeck.mainPileDeck.last!).png")
                    
                    pileOfCardsCount.text = String(newDeck.mainPileDeck.count)
                    
                    
                    currentTurn = "2"
                    
                } else {
                    newGame()
                }
            }
        }
    }
    
    //Player two swipe action
    func buttonDown() {
        if currentTurn == "2" {
            print("i just swiped a card into the deck from player two's hand")
            if (!newDeck.drawCard("2")) {
                playerTwoCardCount.text = String(newDeck.playerTwoDeck.count)
                pileOfCards.image = UIImage(named: "\(newDeck.mainPileDeck.last!).png")
                pileOfCardsCount.text = String(newDeck.mainPileDeck.count)
                currentTurn = "1"
            } else {
                newGame()
            }
        }
    }
    
    @IBAction func playerOneSlap(sender: AnyObject) {
        if newDeck.mainPileDeck.count != 0 {
            let prefix = String(newDeck.mainPileDeck.last!.characters.prefix(4))
            if prefix == "Jack" {
                newDeck.wonPile("1")
                playerOneCardCount.text = String(newDeck.playerOneDeck.count)
                pileOfCards.image = UIImage(named: "none.png")
                pileOfCardsCount.text = "0"
            }
        }
    }
    
    
    @IBAction func playerTwoSlap(sender: AnyObject) {
        print("player two slapped a jack supposedly")
        if newDeck.mainPileDeck.count != 0 {
            let prefix = String(newDeck.mainPileDeck.last!.characters.prefix(4))
            if prefix == "Jack" {
                newDeck.wonPile("2")
                playerTwoCardCount.text = String(newDeck.playerTwoDeck.count)
                pileOfCards.image = UIImage(named: "none.png")
                pileOfCardsCount.text = "0"
            }
        }
    }
}
