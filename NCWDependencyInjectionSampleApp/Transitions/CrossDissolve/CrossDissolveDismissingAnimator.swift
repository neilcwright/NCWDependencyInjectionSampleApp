//
//  CrossDissolveDismissingAnimator.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 7/17/18.
//  Copyright © 2018 Neil Wright. All rights reserved.
//

import UIKit

final class CrossDissolveDismissingAnimator: NSObject, UIViewControllerAnimatedTransitioning {
    func transitionDuration(using transitionContext: UIViewControllerContextTransitioning?) -> TimeInterval {
        return 0.75
    }
    
    func animateTransition(using transitionContext: UIViewControllerContextTransitioning) {
        // get container from transition context
        let containerView = transitionContext.containerView
        guard let fromViewController = transitionContext.viewController(forKey: .from) else {
            assertionFailure("expect to view controller to be available from transition context")
            return
        }
        
        // any setup (pre animation for the fromViewController view.
        fromViewController.view.alpha = 1.0
        
        // add its view to the temporal container view
        containerView.addSubview(fromViewController.view)
        
        UIView.animate(
            withDuration: self.transitionDuration(using: transitionContext),
            delay: 0.0,
            usingSpringWithDamping: 0.75,
            initialSpringVelocity: 0.5,
            options: .curveEaseInOut,
            animations: {
                fromViewController.view.alpha = 0.0
            }, completion: { finished in
                transitionContext.completeTransition(finished)
            }
        )
    }
}
