//
//  AnimationController.swift
//  Custom Transition
//
//  Created by 01HW934413 on 19/04/17.
//  Copyright © 2017 01HW934413. All rights reserved.
//

import UIKit

enum Transition: Int {
    case presenting, dismissing
}

class AnimationController: NSObject, UIViewControllerAnimatedTransitioning {
    
    var circle: UIView?
    var bgColor: UIColor?
    var transition: Transition = .presenting
    var buttonOrigin: CGPoint = CGPoint.zero
    
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        if transition == .presenting {
            return 0.5
        } else {
            return 0.3
        }
    }
    
    func frameForCircle(centre: CGPoint, size: CGSize, start: CGPoint) -> CGRect {
        let lengthX =   fmax(start.x, size.width - start.x)
        let lengthY = fmax(start.y, size.height - start.y)
        
        let offset = sqrt(lengthX * lengthX + lengthY * lengthY) * 2
        let size = CGSize(width: offset, height: offset)
        
        return CGRect(origin: CGPoint.zero, size: size)
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        
        let containerView = transitionContext.containerView
        
        if transition == .presenting {
            let presentedView = transitionContext.view(forKey: UITransitionContextViewKey.to)!
            let originalCenter = presentedView.center
            let originalSize = presentedView.frame.size
            
            circle = UIView(frame: frameForCircle(centre: originalCenter, size: originalSize, start: buttonOrigin))
            circle!.layer.cornerRadius = circle!.frame.size.height / 2
            circle!.center = buttonOrigin
            
            circle!.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
            
            circle!.backgroundColor = bgColor
            
            containerView.addSubview(circle!)
            
            presentedView.center = buttonOrigin
            presentedView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
            
            presentedView.backgroundColor = bgColor
            
            containerView.addSubview(presentedView)
            
            UIView.animate(withDuration: 0.5, animations: {
                self.circle!.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                presentedView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                presentedView.center = originalCenter
            }) {
                (_) -> Void in
                
                transitionContext.completeTransition(true)
            }
        } else {
            let returningView = transitionContext.view(forKey: UITransitionContextViewKey.from)!
            let originalCenter = returningView.center
            let originalSize = returningView.frame.size
            
            circle!.frame = frameForCircle(centre: originalCenter, size: originalSize, start: buttonOrigin)
            circle!.layer.cornerRadius = circle!.frame.size.height / 2
            circle!.center = buttonOrigin
            
            UIView.animate(withDuration: 0.3, animations: {
                self.circle!.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                returningView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
                returningView.center = self.buttonOrigin
                returningView.alpha = 0
            }, completion:{
                (_)-> Void in
                    returningView.removeFromSuperview()
                    self.circle?.removeFromSuperview()
                    transitionContext.completeTransition(true)
                })
            
            
        }
    }

}
