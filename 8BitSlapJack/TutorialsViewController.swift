//
//  TutorialsViewController.swift
//  8BitSlapJack
//
//  Created by Alex Takahashi on 8/16/16.
//  Copyright © 2016 Jack Chen. All rights reserved.
//

import Foundation
import UIKit

class TutorialsViewController: UIViewController {
    
    @IBOutlet weak var handImage: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        handImage.transform = CGAffineTransformMakeRotation(CGFloat(M_PI_2))
        Animations.animateHand(hand: self.handImage)
    }
}