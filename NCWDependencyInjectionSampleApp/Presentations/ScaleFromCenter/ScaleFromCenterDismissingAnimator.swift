//
//  ScaleFromCenterDismissingAnimator.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 7/17/18.
//  Copyright © 2018 Neil Wright. All rights reserved.
//
import UIKit

/// Animator for dismissing a view controller to scale zero center of screen bounds
final class ScaleFromCenterDismissingAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.75
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // get container from transition context
        let containerView = transitionContext.containerView
        guard let fromViewController = transitionContext.viewController(forKey: .from) else {
            assertionFailure("expect fromViewController to be available from transition context")
            return
        }
        
        // any setup (pre animation for the toViewController's view.
        fromViewController.view.transform = CGAffineTransform.identity
        
        // add its view to the temporal container view
        containerView.addSubview(fromViewController.view)
        
        UIView.animate(
            withDuration: self.transitionDuration(using: transitionContext),
            delay: 0.0,
            usingSpringWithDamping: 0.75,
            initialSpringVelocity: 0.5,
            options: .curveEaseInOut,
            animations: {
                fromViewController.view.transform = CGAffineTransform(
                    scaleX: 0.01,
                    y: 0.01
                )
            }, completion: { finished in
            transitionContext.completeTransition(finished)
        })
    }
}
