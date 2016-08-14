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
    
    var game = Deck()
    var isPlayerOneTurn = "1"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        swipeControl(playerOneSwiped, playerTwoSwiped, pileSwiped)
        Animations.invertP2(playerTwoCardCount, playerTwoTextLabel, playerTwoDeckImage)
        Animations.animateSelectedDeck(self.playerOneDeckView)
        self.playerOneDeckView.alpha = 1.0
        self.redXImageView.alpha = 0.0
        
        newGame()
    }
    
    func swipeControl(p1SwipeButton: UIButton, _ p2SwipeButton: UIButton, _ deckSwipeButton: UIButton) {
        let swipeButtonUp = UISwipeGestureRecognizer(target: self, action: "p1DeckSwipe")
        let swipeButtonDown = UISwipeGestureRecognizer(target: self, action: "p2DeckSwipe")
        let pileSwipeUp = UISwipeGestureRecognizer(target: self, action: "p2JackSwipe")
        let pileSwipeDown = UISwipeGestureRecognizer(target: self, action: "p1JackSwipe")
        swipeButtonUp.direction = UISwipeGestureRecognizerDirection.Up
        swipeButtonDown.direction = UISwipeGestureRecognizerDirection.Down
        pileSwipeUp.direction = UISwipeGestureRecognizerDirection.Up
        pileSwipeDown.direction = UISwipeGestureRecognizerDirection.Down
        
        p1SwipeButton.addGestureRecognizer(swipeButtonUp)
        p2SwipeButton.addGestureRecognizer(swipeButtonDown)
        deckSwipeButton.addGestureRecognizer(pileSwipeUp)
        deckSwipeButton.addGestureRecognizer(pileSwipeDown)
    }

    func p2JackSwipe() {
        if game.mainPileDeck.count != 0 {
            let prefix = String(game.mainPileDeck.last!.characters.prefix(4))
            if prefix == "Jack" {
                game.winningPlayer(false)
                playerTwoCardCount.text = String(game.playerTwoDeck.count)
                cleanTheDeck()
            }
        }
    }
    
    func p1JackSwipe() {
        if game.mainPileDeck.count != 0 {
            let prefix = String(game.mainPileDeck.last!.characters.prefix(4))
            if prefix == "Jack" {
                game.winningPlayer(true)
                playerOneCardCount.text = String(game.playerOneDeck.count)
                cleanTheDeck()
            }
        }
    }
    
    func newGame() {
        game = Deck()
        game.shuffleArray()
        game.giveCards()
        playerOneCardCount.text = String(game.playerOneDeck.count)
        playerTwoCardCount.text = String(game.playerTwoDeck.count)
    }
    

    func p1DeckSwipe() {
        if isPlayerOneTurn == "1" {
            if playerOneCardCount == 0 {
                print("game is over!")
                newGame()
            } else {
                print("i just swiped a card into the deck from player one's hand")
                //            print(game.mainPile)
                if (!game.drawCard(true)) {
                    playerOneCardCount.text = String(game.playerOneDeck.count)
                    Animations.showNextCardOnPile(pileOfCards, withCardName: self.game.mainPileDeck.last!)
                    Animations.animatePenalty(penaltyLabel)
                    Animations.animateBigRedX(redXImageView)
                    pileOfCardsCount.text = String(game.mainPileDeck.count)
                    
                    
                    isPlayerOneTurn = "2"
                    Animations.animateSelectedDeck(self.playerTwoDeckView)
                    Animations.stopAnimatingSelectedDeck(self.playerOneDeckView)
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
            if (!game.drawCard(false)) {
                playerTwoCardCount.text = String(game.playerTwoDeck.count)
                Animations.showNextCardOnPile(pileOfCards, withCardName: self.game.mainPileDeck.last!)
                pileOfCardsCount.text = String(game.mainPileDeck.count)
                isPlayerOneTurn = "1"
                
                Animations.animateSelectedDeck(self.playerOneDeckView)
                Animations.stopAnimatingSelectedDeck(self.playerTwoDeckView)
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
