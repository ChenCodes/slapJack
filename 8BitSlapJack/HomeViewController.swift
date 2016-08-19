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
    
    @IBOutlet weak var multiplayerImage: UIImageView!
    

    @IBAction func goToBrowser(sender: AnyObject) {
        let url = NSURL(string: "https://strcatstudios.github.io/")!
        UIApplication.sharedApplication().openURL(url)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("did i even get here")
        swipeControl()
        handImage.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2))

    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        Animations.animateHand(hand: self.handImage)
        Animations.animateInstructions(label: self.instructionLabel)
        Animations.animateMultiplayerImage(self.multiplayerImage)
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