//
//  Animations.swift
//  8BitSlapJack
//
//  Copyright (c) 2016 StrCat. All rights reserved.
//

import Foundation
import UIKit

class Animations {

    static func invertP2(p2CardCount: UILabel, _ p2TextLabel: UILabel, _ p2DeckImage: UIImageView) {
        
        p2CardCount.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
        p2TextLabel.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
        p2DeckImage.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
    }
    
    static func animateMultiplayerImage(image: UIImageView) {
        UIView.animateWithDuration(1.0, delay: 0.0, options: [UIViewAnimationOptions.CurveEaseInOut, UIViewAnimationOptions.Repeat, UIViewAnimationOptions.Autoreverse, UIViewAnimationOptions.AllowUserInteraction], animations: {
            image.transform = CGAffineTransformMakeScale(1.1, 1.1)
            }, completion: nil)
        
//        UIView.animateWithDuration(0.25 ,
//                                   options: [UIViewAnimationOptions.CurveEaseInOut, UIViewAnimationOptions.Repeat, UIViewAnimationOptions.Autoreverse, UIViewAnimationOptions.AllowUserInteraction],
//                                   animations: {
//                                    image.transform = CGAffineTransformMakeScale(2, 2)
//            },
//                                   completion: { finish in
//                                    UIView.animateWithDuration(0.25){
//                                        image.transform = CGAffineTransformIdentity
//                                    }
//        })
    }

    static func animateSelectedDeck(deck: UIView, withduration duration: NSTimeInterval = 1.0) {
        UIView.animateWithDuration(duration,
                                   delay: 0.0,
                                   options: [UIViewAnimationOptions.CurveEaseInOut, UIViewAnimationOptions.Repeat, UIViewAnimationOptions.Autoreverse, UIViewAnimationOptions.AllowUserInteraction],
                                   animations: {
                                    deck.alpha = 0.0
                                    },
                                   completion: nil
        )
    }
    
    static func animateBigRedX(bigX: UIImageView) {
        bigX.alpha = 0.5
        UIView.animateWithDuration(0.2) { () -> Void in
            
            UIView.animateWithDuration(0.01,
                                       delay: 0.0,
                                       options: [UIViewAnimationOptions.CurveEaseInOut, UIViewAnimationOptions.AllowUserInteraction, UIViewAnimationOptions.Autoreverse],
                                       animations: {
                                        bigX.alpha = 1.0
                                        },
                                       completion: nil)
            }
        bigX.alpha = 0.0
    }
    
    static func stopAnimatingSelectedDeck(deck: UIView, withDuration duration: NSTimeInterval = 1.0) {
        UIView.animateWithDuration(duration,
                                   delay: 0.0,
                                   options: [UIViewAnimationOptions.CurveEaseInOut, UIViewAnimationOptions.Repeat, UIViewAnimationOptions.Autoreverse, UIViewAnimationOptions.AllowUserInteraction],
                                   animations: {
                                    deck.alpha = 1.0
                                    },
                                   completion: nil
        )
    }
    
    static func showNextCardOnPile(pile: UIImageView, withCardName name: String, withDuration duration: NSTimeInterval = 0.25) {
        pile.alpha = 0.5
        UIView.animateWithDuration(duration,
                                   delay: 0.0,
                                   options: [UIViewAnimationOptions.CurveEaseInOut, UIViewAnimationOptions.AllowUserInteraction],
                                   animations: {
                                    pile.image = UIImage(named: "\(name).png")
                                    pile.alpha = 1.0
                                    },
                                   completion: nil
        )
    }
    
    static func animatePenalty(penalty: UILabel) {
        penalty.alpha = 1.0
        
        UIView.animateWithDuration(0.5) { () -> Void in
            penalty.transform = CGAffineTransformMakeRotation(CGFloat(M_PI))
        }
        
        UIView.animateWithDuration(0.5,
                                   delay: 0.25,
                                   options: UIViewAnimationOptions.CurveEaseIn,
                                   animations: { () -> Void in
                                    penalty.transform = CGAffineTransformMakeRotation(CGFloat(M_PI * 2))
                                    },
                                   completion: nil
        )
        
        UIView.animateWithDuration(2) { () -> Void in
            penalty.transform = CGAffineTransformMakeRotation(CGFloat(0))
            penalty.alpha = 0.0
        }
        
        UIView.animateWithDuration(0.25 ,
                                   animations: {
                                    penalty.transform = CGAffineTransformMakeScale(2, 2)
                                    },
                                   completion: { finish in
                                    UIView.animateWithDuration(0.25){
                                        penalty.transform = CGAffineTransformIdentity
                                    }
        })
    }

    static func animateHand(duration duration: NSTimeInterval = 1.5, hand hand: UIView) {
        UIView.animateWithDuration(duration,
                                   delay: 0.0,
                                   options: [UIViewAnimationOptions.CurveEaseInOut, UIViewAnimationOptions.Repeat, UIViewAnimationOptions.AllowUserInteraction],
                                   animations: {
                                    hand.alpha = 0.0
                                    hand.center.y -= 150
            },
                                   completion: nil
        )
    }
    
    static func animateInstructions(duration duration: NSTimeInterval = 1.0, label: UILabel) {
        UIView.animateWithDuration(1,
                                   delay: 0.0,
                                   options: [UIViewAnimationOptions.CurveEaseInOut, UIViewAnimationOptions.Repeat, UIViewAnimationOptions.Autoreverse, UIViewAnimationOptions.AllowUserInteraction],
                                   animations: {
                                    label.alpha = 0.0
            },
                                   completion: nil)
    }
    
}
