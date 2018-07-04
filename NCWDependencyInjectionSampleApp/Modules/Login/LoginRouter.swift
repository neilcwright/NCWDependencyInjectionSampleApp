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
    
    /// Will inform router to route to home view.
    func routeToHomeView()
}

// MARK: Classes

final class LoginRouter: LoginRouterType {

    weak var routeProvider: RouteProviderType?
    weak var presentedViewController: UIViewController?
    
    deinit {
        print("Login router deinit")
    }

    func loadView(fromViewController: UIViewController) {
        guard let presentedViewController = self.routeProvider?.resolve(LoginViewControllerType.self) as? UIViewController else {
            assertionFailure("expected Login view controller type to be registered w/ container")
            return
        }
        
        fromViewController.present(presentedViewController, animated: true, completion: nil)
        self.presentedViewController = presentedViewController
    }
    
    func routeToHomeView() {
        guard let homeRoute = self.routeProvider?.route(HomeRouterType.self),
            let presentedViewController = self.presentedViewController else {
                
                assertionFailure("expected home route to be registered w/ container")
                return
        }
        
        homeRoute.loadView(from: presentedViewController)
    }
}
