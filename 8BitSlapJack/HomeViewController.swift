//
//  HomeViewController.swift
//  8BitSlapJack
//
//  Copyright (c) 2016 StrCat. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var playGameDeckSwipe: UIButton!
    @IBOutlet weak var handImage: UIImageView!
    @IBOutlet weak var instructionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("did i even get here")
        swipeControl()
//        handImage.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
//        Animations.animateHand(hand: self.handImage)
//        Animations.animateInstructions(label: self.instructionLabel)
        
    }
    
    func playSwipe() {
        print("got into playswipe")
        self.performSegueWithIdentifier("showPlay", sender: self)
    }
    
    func swipeControl() {
        print("came into swipeControl")
        let swipeButtonUp = UISwipeGestureRecognizer(target: self, action: "playSwipe")
        swipeButtonUp.direction = UISwipeGestureRecognizerDirection.Up
        self.playGameDeckSwipe.addGestureRecognizer(swipeButtonUp)
    }
}