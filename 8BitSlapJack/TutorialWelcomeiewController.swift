//
//  TutorialWelcomeViewController.swift
//  8BitSlapJack
//
//  Created by Alex Takahashi on 8/16/16.
//  Copyright © 2016 Jack Chen. All rights reserved.
//

import Foundation
import UIKit

class TutorialWelcomeViewController: Tutorial {
    
    @IBOutlet weak var handImage: UIImageView!
    @IBOutlet weak var tutorialDeckSwipe: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.swipeControlWithButton(tutorialDeckSwipe)
        handImage.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
    }
    
    override func showNextPageWithIdentifier() {
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("deckSwipe") as! TutorialDeckSwipeViewController
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        Animations.animateHand(hand: self.handImage)
    }

}