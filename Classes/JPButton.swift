//
//  BreathingButton.swift
//  JPButtonDemo
//
//  Created by Josip Petric on 14/09/2017.
//  Copyright © 2017 BitForest. All rights reserved.
//

import UIKit

open class JPButton: UIButton {
    
    fileprivate let kBorderRunnerViewTag = 456754321
    
    // MARK: - Breathing button properties

    // Set to false to disable breathing animation
    @IBInspectable open var breathingEnabled: Bool = false
    // Time needed for button to make one "breath"
    @IBInspectable open var breathDuration: CGFloat = 3.0
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        layer.masksToBounds = true
    }
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        layer.masksToBounds = true
    }
    
    // Breathing functionality is added when user taps and holds the button and removed when 
    // the button is released
    override open func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        startBreathing()
    }
    
    override open func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
       // stopBreathing()
        super.touchesEnded(touches, with: event)
    }
    
    fileprivate func startBreathing() {
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
    
    fileprivate func stopBreathing() {
        if breathingEnabled {
            self.layer.removeAllAnimations()
            UIView.animate(withDuration: 0.4, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.0, options: [.allowUserInteraction], animations: {
                self.transform = CGAffineTransform.identity
            }, completion: nil)
        }
    }
}


// MARK: - Border Runner Animation

extension JPButton {
    open func startBorderRunner(withRunnerColor color: UIColor, runnerSize size: CGSize, isRound: Bool = false, timeToGoRound: Double = 2.0, withBreathing: Bool = false) {
        self.stopAndRemoveBorderRunner()
        
        isUserInteractionEnabled = false
        
        DispatchQueue.main.async {
            let runnerView = UIView(frame: CGRect(x: 0, y: 0, width: size.width, height: size.height))
            runnerView.layer.masksToBounds = true
            if isRound {
                runnerView.layer.cornerRadius = CGFloat(size.height) / 2.0
            }
            runnerView.backgroundColor = color
            runnerView.tag = self.kBorderRunnerViewTag
            
            self.addSubview(runnerView)
            runnerView.center = CGPoint(x: 0.0, y: 0.0)
            
            if withBreathing {
                self.breathingEnabled = true
                self.startBreathing()
            }
            
            UIView.animateKeyframes(withDuration: timeToGoRound, delay: 0.0, options: [.repeat], animations: {
                UIView.addKeyframe(withRelativeStartTime: 0.0, relativeDuration: 0.22, animations: {
                    runnerView.center = CGPoint(x: self.bounds.size.width, y: 0.0)
                })
                UIView.addKeyframe(withRelativeStartTime: 0.22, relativeDuration: 0.03, animations: {
                    runnerView.bounds = CGRect(x: 0, y: 0, width: size.height, height: size.width)
                })
                UIView.addKeyframe(withRelativeStartTime: 0.25, relativeDuration: 0.22, animations: {
                    runnerView.center = CGPoint(x: self.bounds.size.width, y: self.bounds.size.height)
                })
                UIView.addKeyframe(withRelativeStartTime: 0.47, relativeDuration: 0.03, animations: {
                    runnerView.bounds = CGRect(x: 0, y: 0, width: size.width, height: size.height)
                })
                UIView.addKeyframe(withRelativeStartTime: 0.5, relativeDuration: 0.22, animations: {
                    runnerView.center = CGPoint(x: 0, y: self.bounds.size.height)
                })
                UIView.addKeyframe(withRelativeStartTime: 0.72, relativeDuration: 0.03, animations: {
                    runnerView.bounds = CGRect(x: 0, y: 0, width: size.height, height: size.width)
                })
                UIView.addKeyframe(withRelativeStartTime: 0.75, relativeDuration: 0.25, animations: {
                    runnerView.center = CGPoint(x: 0, y: 0)
                })
                UIView.addKeyframe(withRelativeStartTime: 0.96, relativeDuration: 0.04, animations: {
                    runnerView.bounds = CGRect(x: 0, y: 0, width: size.width, height: size.height)
                })
                
            }, completion: nil)
        }
    }
    
    open func stopAndRemoveBorderRunner() {
        isUserInteractionEnabled = true
        DispatchQueue.main.async {
            self.layer.removeAllAnimations()
            if let runnerView = self.viewWithTag(self.kBorderRunnerViewTag) {
                runnerView.removeFromSuperview()
            }
        }
        
    }
}
