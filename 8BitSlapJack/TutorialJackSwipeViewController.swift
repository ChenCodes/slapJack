//
//  TutorialJackSwipeViewController.swift
//  8BitSlapJack
//
//  Created by Alex Takahashi on 8/18/16.
//  Copyright © 2016 Jack Chen. All rights reserved.
//

import Foundation
import UIKit

class TutorialJackSwipeViewController: Tutorial {
    
    @IBOutlet weak var jackSwipe: UIButton!
    @IBOutlet weak var handImage: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        swipeControlWithButton(jackSwipe)
        handImage.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
    }
    
    override func showNextPageWithIdentifier() {
        let vc = self.storyboard?.instantiateViewControllerWithIdentifier("win") as! TutorialWinViewController
        self.presentViewController(vc, animated: true, completion: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(true)
        animateHand(duration: 1.5, hand: self.handImage)
    }
    
    override func swipeControlWithButton(button: UIButton) {
        print("came into swipeControl")
        let swipeButtonDown = UISwipeGestureRecognizer(target: self, action: #selector(showNextPageWithIdentifier))
        swipeButtonDown.direction = UISwipeGestureRecognizerDirection.Down
        button.addGestureRecognizer(swipeButtonDown)
    }
    
    func animateHand(duration duration: NSTimeInterval = 1.5, hand hand: UIView) {
        UIView.animateWithDuration(duration,
                                   delay: 0.0,
                                   options: [UIViewAnimationOptions.CurveEaseInOut, UIViewAnimationOptions.Repeat, UIViewAnimationOptions.AllowUserInteraction],
                                   animations: {
                                    hand.alpha = 0.0
                                    hand.center.y += 200
            },
                                   completion: nil
        )
    }
    
}