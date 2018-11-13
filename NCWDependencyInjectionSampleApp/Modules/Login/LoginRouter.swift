//
//  LoginRouter.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 07-01-2018.
//

import UIKit

// MARK: Protocols

/// The Login router type protocol.
protocol LoginRouterType: RouteType, LoginPresenterToRouterType {
    
    func loadView(fromViewController: UIViewController)
}

/// Presenter->Router interface.
protocol LoginPresenterToRouterType {
    
    /// Will request router to route to home view.
    func routeToHomeView()
    
    /// Will request router to route to home tab bar view.
    func routeToHomeTabBarView()
    
    /// Will request the create account view and route to it.
    func routeToCreateAccountView()
    
    /// Will request router to route to error view.
    func routeToError()
}

// MARK: Classes

final class LoginRouter: NSObject, LoginRouterType {

    weak var wireframe: WireframeType?
    weak var presentedViewController: UIViewController?
    
    deinit {
        print("Login router deinit")
    }
    
    init(wireframe: WireframeType? = nil) {
        self.wireframe = wireframe
    }

    func loadView(fromViewController: UIViewController) {
        guard let presentedViewController = self.wireframe?.resolve(LoginViewControllerType.self) as? UIViewController else {
            assertionFailure("expected Login view controller type to be registered w/ container")
            return
        }
        
        presentedViewController.transitioningDelegate = self
        presentedViewController.modalPresentationStyle = .custom
        fromViewController.present(presentedViewController, animated: true, completion: nil)
        self.presentedViewController = presentedViewController
    }
    
    func routeToHomeView() {
        guard let homeRoute = self.wireframe?.route(HomeRouterType.self),
            let presentedViewController = self.presentedViewController else {
                
                assertionFailure("expected home route to be registered w/ container")
                return
        }
        
        homeRoute.loadView(fromViewController: presentedViewController)
    }
    
    func routeToHomeTabBarView() {
        guard let homeTabBarRoute = self.wireframe?.route(HomeTabBarRouterType.self),
            let presentedViewController = self.presentedViewController else {
                
            assertionFailure("expected home tab bar route to be registered w/ container")
            return
        }

        homeTabBarRoute.loadView(fromViewController: presentedViewController)
    }
    
    func routeToCreateAccountView() {
        guard let createAccountRoute = self.wireframe?.route(CreateAccountRouterType.self),
            let presentedViewController = self.presentedViewController else {
                
                assertionFailure("expected create account route to be registered w/ container")
                return
        }
        
        createAccountRoute.loadView(fromViewController: presentedViewController)
    }
    
    func routeToError() {
        guard let errorRoute = self.wireframe?.route(ErrorRouterType.self),
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
extension LoginRouter: UIViewControllerTransitioningDelegate {
    
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
