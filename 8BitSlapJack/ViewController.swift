//
//  ViewController.swift
//  8BitSlapJack
//
//  Created by Jack Chen on 7/7/16.
//  Copyright © 2016 Jack Chen. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    
    //First we need a deck of all the cards, they can just be represented as strings.
    
    
    @IBOutlet weak var pileOfCards: UIImageView!
    
    
    var newDeck = Deck()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
        
        var swipeButtonUp: UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: "buttonUp")
        swipeButtonUp.direction = UISwipeGestureRecognizerDirection.Up

        self.playerOneSwiped.addGestureRecognizer(swipeButtonUp)

        
        
        print("playerOne has this many cards: ",newDeck.playerOneDeck.count)
        print("playerTwo has this many cards: ",newDeck.playerTwoDeck.count)
    }

    @IBOutlet weak var playerOneSwiped: UIButton!
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    var currentTurn = "one"
    func newGame() {
        newDeck.shuffleArray()
        newDeck.giveCards()
        
    }
    
    //Player one swipe action
    func buttonUp() {
        if currentTurn == "one" {
            print("i just swiped a card into the deck from player one's hand")
            
            pileOfCards.image = UIImage(named: "\(newDeck.mainPile).png")
            newDeck.drawCard("1")
        }
    }
    
    
    
    //Player two swipe action
    func buttonDown() {
        print("i just swiped a card into the deck from player two's hand")
        pileOfCards.image = UIImage(named: "\(newDeck.mainPile).png")
        newDeck.drawCard("2")
    }
    
    
    

    
    


}

