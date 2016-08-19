//
//  TutorialWinViewController.swift
//  8BitSlapJack
//
//  Created by Alex Takahashi on 8/18/16.
//  Copyright © 2016 Jack Chen. All rights reserved.
//

import Foundation
import UIKit

class TutorialWinViewController : Tutorial {
    
    @IBOutlet weak var dekSwipe: UIButton!
    @IBOutlet weak var handImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        super.animateHand(self.handImage)
        super.swipeControlWithButton(dekSwipe)
        handImage.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
    }
    
    override func showNextPageWithIdentifier() {
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("enjoy") as! TutorialEnjoyViewController
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        Animations.animateHand(hand: self.handImage)
    }
}