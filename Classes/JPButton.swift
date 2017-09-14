//
//  BreathingButton.swift
//  JPButtonDemo
//
//  Created by Josip Petric on 14/09/2017.
//  Copyright © 2017 BitForest. All rights reserved.
//

import UIKit

class JPButton: UIButton {
    
    // MARK: - Breathing button properties

    // Set to false to disable breathing animation
    @IBInspectable open var breathingEnabled: Bool = false
    // Time needed for button to make one "breath"
    @IBInspectable open var breathDuration  : CGFloat = 3.0
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)

        guard breathingEnabled else { return }
        
        UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: [.allowUserInteraction], animations: {
            self.transform = CGAffineTransform(scaleX: 0.94, y: 0.94)
        }, completion: {
            completed in
            if completed {
                UIView.animateKeyframes(withDuration: TimeInterval(self.breathDuration), delay: 0.0, options: [.repeat, .allowUserInteraction], animations: {
                    UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.5) {
                        self.transform = CGAffineTransform(scaleX: 0.99, y: 0.99)
                    }
                    UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.5) {
                        self.transform = CGAffineTransform(scaleX: 0.94, y: 0.94)
                    }
                }, completion: {
                    [unowned self] _ in
                    self.transform = CGAffineTransform.identity
                })
            }
        })
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if breathingEnabled {
            self.layer.removeAllAnimations()
            UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: [.allowUserInteraction], animations: {
                self.transform = CGAffineTransform.identity
            }, completion: nil)
        }

        super.touchesEnded(touches, with: event)
    }
}
