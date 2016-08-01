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
    //First we need a deck of all the cards, they can just be represented as strings.
    @IBOutlet weak var playerTwoTextLabel: UILabel!
    
    
    @IBOutlet weak var pileOfCards: UIImageView!
    
    
    @IBOutlet weak var pileOfCardsCount: UILabel!
    var newDeck = Deck()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
        playerTwoCardCount.transform = CGAffineTransformMakeRotation(CGFloat(M_PI));
        playerTwoTextLabel.transform = CGAffineTransformMakeRotation(CGFloat(M_PI));


        
        
        
        var swipeButtonUp: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "buttonUp")
        swipeButtonUp.direction = UISwipeGestureRecognizerDirection.Up

        self.playerOneSwiped.addGestureRecognizer(swipeButtonUp)
        
        
        var swipeButtonDown: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "buttonDown")
        swipeButtonDown.direction = UISwipeGestureRecognizerDirection.Down
        
        self.playerTwoSwiped.addGestureRecognizer(swipeButtonDown)
        
        
        newGame()
        
        
        
    }

    @IBOutlet weak var playerOneSwiped: UIButton!
    @IBOutlet weak var playerTwoSwiped: UIButton!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    var currentTurn = "1"
    func newGame() {
        newDeck = Deck()
        newDeck.shuffleArray()
        newDeck.giveCards()
        
        playerOneCardCount.text = String(newDeck.playerOneDeck.count)
        playerTwoCardCount.text = String(newDeck.playerTwoDeck.count)
        
        
    }
    
    //Player one swipe action
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
                
                //
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

