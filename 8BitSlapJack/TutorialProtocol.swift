//
//  TutorialProtocol.swift
//  8BitSlapJack
//
//  Created by Alex Takahashi on 8/18/16.
//  Copyright © 2016 Jack Chen. All rights reserved.
//

import Foundation
import UIKit

class Tutorial : UIViewController {
    
    func animateHand(hand: UIImageView) {
//        Animations.animateHand(hand: hand)
    }
    
    func swipeControlWithButton(button: UIButton) {
        print("came into swipeControl")
        let swipeButtonUp = UISwipeGestureRecognizer(target: self, action: #selector(showNextPageWithIdentifier))
        swipeButtonUp.direction = UISwipeGestureRecognizerDirection.Up
        button.addGestureRecognizer(swipeButtonUp)
    }
    
    func showNextPageWithIdentifier() {}
    
}