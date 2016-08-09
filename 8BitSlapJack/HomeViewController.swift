//
//  HomeViewController.swift
//  8BitSlapJack
//
//  Created by Alex Takahashi on 8/8/16.
//  Copyright © 2016 Jack Chen. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {
    
    @IBOutlet weak var playGameDeckSwipe: UIButton!
    @IBOutlet weak var handImage: UIImageView!
    @IBOutlet weak var instructionLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        swipeControl()
        handImage.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
        animateHand(hand: self.handImage)
        animateInstructions(label: self.instructionLabel)
        
    }
    
    func playSwipe() {
        self.performSegueWithIdentifier("showPlay", sender: self)
    }
    
    func swipeControl() {
        let swipeButtonUp = UISwipeGestureRecognizer(target: self, action: "playSwipe")
        swipeButtonUp.direction = UISwipeGestureRecognizerDirection.Up
        self.playGameDeckSwipe.addGestureRecognizer(swipeButtonUp)
    }
    
    func animateHand(duration duration: NSTimeInterval = 1.5, hand hand: UIView) {
        UIView.animateWithDuration(duration,
                                   delay: 1.0,
                                   options: [UIViewAnimationOptions.CurveEaseInOut, UIViewAnimationOptions.Repeat, UIViewAnimationOptions.AllowUserInteraction],
                                   animations: {
                                        hand.alpha = 0.0
                                        hand.center.y -= 150
                                    },
                                   completion: nil
        )
    }
    
    func animateInstructions(duration duration: NSTimeInterval = 1.0, label: UILabel) {
        UIView.animateWithDuration(1,
                                   delay: 0.0,
                                   options: [UIViewAnimationOptions.CurveEaseInOut, UIViewAnimationOptions.Repeat, UIViewAnimationOptions.Autoreverse, UIViewAnimationOptions.AllowUserInteraction],
                                   animations: {
                                    label.alpha = 0.0
            },
                                   completion: nil)
    }
}