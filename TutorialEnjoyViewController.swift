//
//  TutorialEnjoyViewController.swift
//  8BitSlapJack
//
//  Created by Alex Takahashi on 8/18/16.
//  Copyright © 2016 Jack Chen. All rights reserved.
//

import Foundation
import UIKit

class TutorialEnjoyViewController : Tutorial {
    
    @IBOutlet weak var deckSwipe: UIButton!
    @IBOutlet weak var handImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.animateHand(self.handImage)
        super.swipeControlWithButton(deckSwipe)
        handImage.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
    }
    
    override func showNextPageWithIdentifier() {
        var storyboard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
        var vc = storyboard.instantiateViewControllerWithIdentifier("Home") as! HomeViewController
        self.showViewController(vc, sender: self)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        Animations.animateHand(hand: self.handImage)
    }
    
}