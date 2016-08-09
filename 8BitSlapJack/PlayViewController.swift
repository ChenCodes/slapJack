//
//  PlayViewController.swift
//  8BitSlapJack
//
//  Created by Jack Chen on 7/7/16.
//  Copyright © 2016 Jack Chen. All rights reserved.
//

import UIKit

class PlayViewController: UIViewController {

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
    
    @IBOutlet weak var pileSwiped: UIButton!
    
    @IBOutlet weak var penaltyLabel: UILabel!
    
    @IBOutlet weak var redXImageView: UIImageView!
    
    var newDeck = Deck()
    var isPlayerOneTurn = "1"
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        invertPlayerTwoSide()
        swipeControl()
        
        newGame()
        animateSelectedDeck(deck: self.playerOneDeckView)
        self.playerOneDeckView.alpha = 1.0
        self.redXImageView.alpha = 0.0
    }
    
    func invertPlayerTwoSide() {
        playerTwoCardCount.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
        playerTwoTextLabel.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
        playerTwoDeckImage.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
    }
    
    func swipeControl() {
        let swipeButtonUp = UISwipeGestureRecognizer(target: self, action: "p1DeckSwipe")
        let swipeButtonDown = UISwipeGestureRecognizer(target: self, action: "p2DeckSwipe")
        let pileSwipeUp = UISwipeGestureRecognizer(target: self, action: "p2JackSwipe")
        let pileSwipeDown = UISwipeGestureRecognizer(target: self, action: "p1JackSwipe")
        swipeButtonUp.direction = UISwipeGestureRecognizerDirection.Up
        swipeButtonDown.direction = UISwipeGestureRecognizerDirection.Down
        pileSwipeUp.direction = UISwipeGestureRecognizerDirection.Up
        pileSwipeDown.direction = UISwipeGestureRecognizerDirection.Down
        
        self.playerOneSwiped.addGestureRecognizer(swipeButtonUp)
        self.playerTwoSwiped.addGestureRecognizer(swipeButtonDown)
        self.pileSwiped.addGestureRecognizer(pileSwipeUp)
        self.pileSwiped.addGestureRecognizer(pileSwipeDown)
    }
    
    func animateBigRedX(bigX: UIImageView) {
        bigX.alpha = 0.5
        UIView.animateWithDuration(0.2) { () -> Void in
            
            UIView.animateWithDuration(0.01,
                                       delay: 0.0,
                                       options: [UIViewAnimationOptions.CurveEaseInOut, UIViewAnimationOptions.AllowUserInteraction, UIViewAnimationOptions.Autoreverse],
                                       animations: {
                                        bigX.alpha = 1.0
                },
                                       completion: nil)
        }
        bigX.alpha = 0.0
        
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
    
    func animatePile(pile: UIImageView) {
        pile.alpha = 0.5
        UIView.animateWithDuration(0.25,
                                   delay: 0.0,
                                   options: [UIViewAnimationOptions.CurveEaseInOut, UIViewAnimationOptions.AllowUserInteraction],
                                   animations: {
                                    pile.image = UIImage(named: "\(self.newDeck.mainPileDeck.last!).png")
                                    pile.alpha = 1.0
            },
                                   completion: nil)
    }
    
    func animatePenalty(penalty: UILabel) {
        penalty.alpha = 1.0
        UIView.animateWithDuration(0.5) { () -> Void in
            
            penalty.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
        }
        
        UIView.animateWithDuration(0.5, delay: 0.25, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
            
            penalty.transform = CGAffineTransformMakeRotation(CGFloat(M_PI * 2))
            }, completion: nil)
        UIView.animateWithDuration(2) { () -> Void in
            
            penalty.transform = CGAffineTransformMakeRotation(CGFloat(0))
            penalty.alpha = 0.0
        }
        
        UIView.animateWithDuration(0.25 ,
                                   animations: {
                                    penalty.transform = CGAffineTransformMakeScale(2, 2)
            },
                                   completion: { finish in
                                    UIView.animateWithDuration(0.25){
                                        penalty.transform = CGAffineTransformIdentity
                                    }
        })
    }
    
    func p2JackSwipe() {
        if newDeck.mainPileDeck.count != 0 {
            let prefix = String(newDeck.mainPileDeck.last!.characters.prefix(4))
            if prefix == "Jack" {
                newDeck.wonPile("2")
                playerTwoCardCount.text = String(newDeck.playerTwoDeck.count)
                cleanTheDeck()
            }
        }
    }
    
    func p1JackSwipe() {
        if newDeck.mainPileDeck.count != 0 {
            let prefix = String(newDeck.mainPileDeck.last!.characters.prefix(4))
            if prefix == "Jack" {
                newDeck.wonPile("1")
                playerOneCardCount.text = String(newDeck.playerOneDeck.count)
                cleanTheDeck()
            }
        }
    }
    
    func newGame() {
        newDeck = Deck()
        newDeck.shuffleArray()
        newDeck.giveCards()
        
        playerOneCardCount.text = String(newDeck.playerOneDeck.count)
        playerTwoCardCount.text = String(newDeck.playerTwoDeck.count)
    }
    

    func p1DeckSwipe() {
        if isPlayerOneTurn == "1" {
            
            if playerOneCardCount == 0 {
                print("game is over!")
                newGame()
            } else {
                print("i just swiped a card into the deck from player one's hand")
                //            print(newDeck.mainPile)
                if (!newDeck.drawCard("1")) {
                    playerOneCardCount.text = String(newDeck.playerOneDeck.count)
                    animatePile(pileOfCards)
                    animatePenalty(penaltyLabel)
                    animateBigRedX(redXImageView)
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

    func p2DeckSwipe() {
        if isPlayerOneTurn == "2" {
            print("i just swiped a card into the deck from player two's hand")
            if (!newDeck.drawCard("2")) {
                playerTwoCardCount.text = String(newDeck.playerTwoDeck.count)
                animatePile(pileOfCards)
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
    
    func cleanTheDeck() {
        pileOfCards.image = UIImage(named: "cardBack.png")
        pileOfCards.alpha = 0.5
        pileOfCardsCount.text = "0"
    }
}
