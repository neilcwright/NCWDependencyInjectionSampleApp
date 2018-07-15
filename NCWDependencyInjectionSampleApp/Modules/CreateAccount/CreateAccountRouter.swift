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
    
    /// Will route to error view.
    func routeToError()
}

// MARK: Classes

final class CreateAccountRouter: CreateAccountRouterType {
    
    weak var routeProvider: RouteProviderType?
    weak var presentedViewController: UIViewController?
    
    deinit {
        print("CreateAccount router deinit")
    }

    func loadView(fromViewController: UIViewController) {
        guard let presentedViewController = self.routeProvider?.resolve(CreateAccountViewControllerType.self) as? UIViewController else {
            assertionFailure("expected CreateAccount view controller type to be registered w/ container")
            return
        }
        
        fromViewController.present(presentedViewController, animated: true, completion: nil)
        self.presentedViewController = presentedViewController
    }
    
    func routeToError() {
        guard let errorRoute = self.routeProvider?.route(ErrorRouterType.self),
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
