//
//  TutorialDeckSwipeViewController.swift
//  8BitSlapJack
//
//  Created by Alex Takahashi on 8/18/16.
//  Copyright © 2016 Jack Chen. All rights reserved.
//

import Foundation
import UIKit

class TutorialDeckSwipeViewController: Tutorial {
 
    
    @IBOutlet weak var handImage: UIImageView!
    @IBOutlet weak var deckSwipe: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.animateHand(self.handImage)
        super.swipeControlWithButton(deckSwipe)
        handImage.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
    }
    
    override func showNextPageWithIdentifier() {
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("jackSwipe") as! TutorialJackSwipeViewController
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        Animations.animateHand(hand: self.handImage)
    }
    
}