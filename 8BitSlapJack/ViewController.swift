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
    
    @IBOutlet weak var playerOneDeckView: UIView!
    @IBOutlet weak var playerTwoDeckView: UIView!
    
    @IBOutlet weak var playerOneSwiped: UIButton!
    @IBOutlet weak var playerTwoSwiped: UIButton!
    
    var newDeck = Deck()
    var isPlayerOneTurn = "1"
    
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
        animateSelectedDeck(deck: self.playerOneDeckView)
    }
    
    func animateSelectedCard(duration: NSTimeInterval = 1.0) {
        UIView.animateWithDuration(duration, animations: {
            self.playerOneDeckView.alpha = 1.0
        })
//        fadeOut()
    }
    
    func animateSelectedDeck(duration duration: NSTimeInterval = 1.0, deck: UIView) {
        UIView.animateWithDuration(1,
                                   delay: 0.0,
                                   options: [UIViewAnimationOptions.CurveEaseInOut, UIViewAnimationOptions.Repeat, UIViewAnimationOptions.Autoreverse, UIViewAnimationOptions.AllowUserInteraction],
                                   animations: {
                                    deck.alpha = 0.0
                                    },
                                   completion: nil)
    }
    
    func stopAnimatingSelectedDeck(duration duration: NSTimeInterval = 1.0, deck: UIView) {
        UIView.animateWithDuration(1,
                                   delay: 0.0,
                                   options: [UIViewAnimationOptions.CurveEaseInOut, UIViewAnimationOptions.Repeat, UIViewAnimationOptions.Autoreverse, UIViewAnimationOptions.AllowUserInteraction],
                                   animations: {
                                    deck.alpha = 1.0
                                    },
                                   completion: nil)
    }
    
    func newGame() {
        newDeck = Deck()
        newDeck.shuffleArray()
        newDeck.giveCards()
        
        playerOneCardCount.text = String(newDeck.playerOneDeck.count)
        playerTwoCardCount.text = String(newDeck.playerTwoDeck.count)
    }
    

    func buttonUp() {
        if isPlayerOneTurn == "1" {
            
            if playerOneCardCount == 0 {
                print("game is over!")
                newGame()
            } else {
                print("i just swiped a card into the deck from player one's hand")
                //            print(newDeck.mainPile)
                if (!newDeck.drawCard("1")) {
                    playerOneCardCount.text = String(newDeck.playerOneDeck.count)
                    pileOfCards.image = UIImage(named: "\(newDeck.mainPileDeck.last!).png")
                    pileOfCards.alpha = 1.0
                    pileOfCardsCount.text = String(newDeck.mainPileDeck.count)
                    
                    
                    isPlayerOneTurn = "2"
                    animateSelectedDeck(deck: self.playerTwoDeckView)
                    stopAnimatingSelectedDeck(deck: self.playerOneDeckView)
                    self.playerOneDeckView.layer.removeAllAnimations()

                    
                } else {
                    newGame()
                }
            }
        }
    }
    
    //Player two swipe action
    func buttonDown() {
        if isPlayerOneTurn == "2" {
            print("i just swiped a card into the deck from player two's hand")
            if (!newDeck.drawCard("2")) {
                playerTwoCardCount.text = String(newDeck.playerTwoDeck.count)
                pileOfCards.image = UIImage(named: "\(newDeck.mainPileDeck.last!).png")
                pileOfCards.alpha = 1.0
                pileOfCardsCount.text = String(newDeck.mainPileDeck.count)
                isPlayerOneTurn = "1"
                
                animateSelectedDeck(deck: self.playerOneDeckView)
                stopAnimatingSelectedDeck(deck: self.playerTwoDeckView)
                self.playerTwoDeckView.layer.removeAllAnimations()
                
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
                cleanTheDeck()
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
                cleanTheDeck()
            }
        }
    }
    
    func cleanTheDeck() {
        pileOfCards.image = UIImage(named: "cardBack.png")
        pileOfCards.alpha = 0.5
        pileOfCardsCount.text = "0"
    }
}
