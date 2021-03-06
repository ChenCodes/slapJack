//
//  PlayViewController.swift
//  8BitSlapJack
//
//  Copyright (c) 2016 StrCat. All rights reserved.
//

import UIKit

class PlayViewController: UIViewController {

    // TODO: General, take out all extraneous print statments and comments
    
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
    
    @IBOutlet weak var redXImageView: UIImageView!
    
    var game = Deck()
    var isPlayerOneTurn = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        swipeControl(playerOneSwiped, playerTwoSwiped, pileSwiped)
        Animations.invertP2(playerTwoCardCount, playerTwoTextLabel, playerTwoDeckImage)
        self.playerOneDeckView.alpha = 1.0
        self.redXImageView.alpha = 0.0
        newGame()
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        Animations.animateSelectedDeck(self.playerOneDeckView)
    }
    
    /**
     This method instantiates a Deck object. Then, it shuffles the deck object of 52 cards and then dipenses the cards evenly between two players. Finally, it shows the number of cards present in each player's deck.
     */
    func newGame() {
        game = Deck()
        game.shuffleDeck()
        game.giveCards()
        playerOneCardCount.text = String(game.playerOneDeck.count)
        playerTwoCardCount.text = String(game.playerTwoDeck.count)
        pileOfCards.image = UIImage(named: "none.png")
        pileOfCardsCount.text = "0"
    }

    /**
     First, this method checks to see if player one swiped when they have no cards. If they have no cards, then the game is over and the newGame method is called.
     If the player tries to swipe their hand into the main pile and is unable to do so, then there will be a red animation that is played on the main pile.
     */
    
    func p1DeckSwipe() {
        if isPlayerOneTurn {
            if playerOneCardCount == 0 {
                print("game is over!")
                newGame()
            } else {
                print("i just swiped a card into the deck from player one's hand")
                
                let successFlip = game.flipCard(true)
                
                if (!successFlip) {
                    playerOneCardCount.text = String(game.playerOneDeck.count)
                    Animations.showNextCardOnPile(pileOfCards, withCardName: self.game.mainPileDeck.last!)
                    pileOfCardsCount.text = String(game.mainPileDeck.count)
                    
                    
                    isPlayerOneTurn = false
                    Animations.animateSelectedDeck(self.playerTwoDeckView)
                    Animations.stopAnimatingSelectedDeck(self.playerOneDeckView)
                    self.playerOneDeckView.layer.removeAllAnimations()
                    
                } else {
                    newGame()
                }
            }
        }
    }
    
    /**
     First, this method checks to see if player two swiped when they have no cards. If they have no cards, then the game is over and the newGame method is called.
     
     If the player tries to swipe their hand into the main pile and is unable to do so, then there will be a red animation that is played on the main pile.
     
     */
    func p2DeckSwipe() {
        if !isPlayerOneTurn  {
            print("i just swiped a card into the deck from player two's hand")
            
            let successFlip = game.flipCard(false)
            
            if (!successFlip) {
                playerTwoCardCount.text = String(game.playerTwoDeck.count)
                Animations.showNextCardOnPile(pileOfCards, withCardName: self.game.mainPileDeck.last!)
                pileOfCardsCount.text = String(game.mainPileDeck.count)
                isPlayerOneTurn = true
                
                Animations.animateSelectedDeck(self.playerOneDeckView)
                Animations.stopAnimatingSelectedDeck(self.playerTwoDeckView)
                self.playerTwoDeckView.layer.removeAllAnimations()
                
            } else {
                newGame()
            }
        }
    }
    
    /**
     This method checks to see if that the swipe was on a "Jack" card. If it was on a "Jack" card, then player one will obtain the cards in the main pile.
     */
    func p1JackSwipe() {
        if game.mainPileDeck.count != 0 {
            let prefix = String(game.mainPileDeck.last!.characters.prefix(4))
            let isPlayerOne = true
            if prefix == "Jack" {
                game.addCardsToPlayersDeck(isPlayerOne)
                playerOneCardCount.text = String(game.playerOneDeck.count)
                cleanTheDeck()
            } else {
                game.burnCardFrom(isPlayerOne)
                
                Animations.animateBigRedX(redXImageView)
                
                playerOneCardCount.text = String(game.playerOneDeck.count)
                pileOfCardsCount.text = String(game.mainPileDeck.count)
                let isPlayerOneTurnNow = true
                if game.playerOneDeck.count == 0 {
                    game.win(!isPlayerOneTurnNow)
                    newGame()
                }
                
            }
        }
    }
    
    
    /**
     This method checks to see if that the swipe was on a "Jack" card. If it was on a "Jack" card, then player two will obtain the cards in the main pile.
    */
    func p2JackSwipe() {
        if game.mainPileDeck.count != 0 {
            let prefix = String(game.mainPileDeck.last!.characters.prefix(4))
            let isPlayerOne = false
            if prefix == "Jack" {
                game.addCardsToPlayersDeck(isPlayerOne)
                playerTwoCardCount.text = String(game.playerTwoDeck.count)
                cleanTheDeck()
            } else {
                game.burnCardFrom(isPlayerOne)
                Animations.animateBigRedX(redXImageView)
                
                playerTwoCardCount.text = String(game.playerTwoDeck.count)
                pileOfCardsCount.text = String(game.mainPileDeck.count)
                let isPlayerOneTurnNow = false
                if game.playerTwoDeck.count == 0 {
                    game.win(!isPlayerOneTurnNow)
                    newGame()
                }
                
                
                
            }
        }
    }
    
    
    func cleanTheDeck() {
        pileOfCards.image = UIImage(named: "none.png")
        pileOfCards.alpha = 0.5
        pileOfCardsCount.text = "0"
    }
    
    /**
     This button deals with swiping cards from player one and player two's decks into the main pile in the middle.
     
     - parameters:
     - p1SwipeButton: This button detects gestures made on the player one's card back.
     - p2SwipeButton: This button detects gestures made on the player two's card back.
     - deckSwipeButton: This button detects gestures made on the pile in the middle.
     */
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
}
