//
//  CreateAccountRouter.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 07-08-2018.
//

import UIKit

// MARK: Protocols

/// The CreateAccount router type protocol.
protocol CreateAccountRouterType: RouteType, CreateAccountPresenterToRouterType {
    
    /// Will load this route's view from the provided presenting view controller.
    ///
    /// - Parameter fromViewController: the presenting view controller.
    func loadView(fromViewController: UIViewController)
}

protocol CreateAccountPresenterToRouterType {
    
    /// Will route to login.
    func routeToLogin()
    
    /// Will route to error view.
    func routeToError()
}

// MARK: Classes

final class CreateAccountRouter: NSObject, CreateAccountRouterType {
    
    weak var appRouter: AppRouterType?
    weak var presentedViewController: UIViewController?
    
    deinit {
        print("CreateAccount router deinit")
    }

    func loadView(fromViewController: UIViewController) {
        guard let presentedViewController = self.appRouter?.resolve(CreateAccountViewControllerType.self) as? UIViewController else {
            assertionFailure("expected CreateAccount view controller type to be registered w/ container")
            return
        }
        
        presentedViewController.transitioningDelegate = self
        presentedViewController.modalPresentationStyle = .custom
        fromViewController.present(presentedViewController, animated: true, completion: nil)
        self.presentedViewController = presentedViewController
    }
    
    func routeToLogin() {
//        guard let loginRoute = self.appRouter?.route(LoginRouterType.self),
//            let presentedViewController = self.presentedViewController else {
//            assertionFailure("expected login route and presented view to be set")
//            return
//        }
//
//        loginRoute.loadView(fromViewController: presentedViewController)
        
        self.presentedViewController?.dismiss(animated: true, completion: nil)
    }
    
    func routeToError() {
        guard let errorRoute = self.appRouter?.route(ErrorRouterType.self),
            let presentedViewController = self.presentedViewController else {
                
                assertionFailure("expected error route to be registered w/ container")
                return
        }
        
        errorRoute.loadView(
            fromViewController: presentedViewController,
            withContext: ErrorContext.generic(retryClosure: nil)
        )
    }
}

// MARK: UIViewControllerTransitioningDelegate
extension CreateAccountRouter: UIViewControllerTransitioningDelegate {
    func animationController(
        forPresented presented: UIViewController,
        presenting: UIViewController,
        source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return CrossDissolvePresentingAnimator()
    }
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return CrossDissolveDismissingAnimator()
    }
}
