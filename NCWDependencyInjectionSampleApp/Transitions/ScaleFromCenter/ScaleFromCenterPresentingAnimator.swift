//
//  ScaleFromCenterPresentingAnimator.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 7/17/18.
//  Copyright © 2018 Neil Wright. All rights reserved.
//

import UIKit


/// Animator for scaling a view controller from center to extend out to screen bounds
final class ScaleFromCenterPresentingAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.75
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // get container from transition context
        let containerView = transitionContext.containerView
        guard let toViewController = transitionContext.viewController(forKey: .to) else {
            assertionFailure("expect to view controller to be available from transition context")
            return
        }
        
        // any setup (pre animation for the toViewController's view.
        toViewController.view.transform = CGAffineTransform(scaleX: CGFloat.leastNormalMagnitude, y: CGFloat.leastNormalMagnitude)
        
        // add its view to the temporal container view
        containerView.addSubview(toViewController.view)
        
        UIView.animate(
            withDuration: self.transitionDuration(using: transitionContext),
            delay: 0.0,
            usingSpringWithDamping: 0.75,
            initialSpringVelocity: 0.5,
            options: .curveEaseInOut,
            animations: {
                toViewController.view.transform = CGAffineTransform(scaleX: 1, y: 1)
            }, completion: { finished in
            transitionContext.completeTransition(finished)
            }
        )
    }
}
