//
//  RootRouter.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 6/16/18.
//  Copyright © 2018 Neil Wright. All rights reserved.
//

import UIKit

// MARK: Protocols

/// The root router type protocol.
protocol RootRouterType: RouteType, RootPresenterToRouterType {
    
    /// Will load this route's view in the provided window and return it after
    /// assigning the view to it.
    ///
    /// - Parameter window: the window that we'll load view into.
    /// - Returns: the loaded window.
    func loadView(in window: UIWindow) -> UIWindow
    
    func redetermineInitialView()
}

protocol RootPresenterToRouterType {
    
    /// Will route to home.
    func routeToHome()
    
    // Will route to login.
    func routeToLogin()
    
    // Will route to error.
    func routeToError()
}

// MARK: Classes

final class RootRouter: RootRouterType {
    
    weak var wireframe: WireframeType?
    weak var presentedViewController: UIViewController?
    
    deinit {
        print("root router deinit")
    }
    
    init(wireframe: WireframeType? = nil) {
        self.wireframe = wireframe
    }
    
    func loadView(in window: UIWindow) -> UIWindow {
        guard let rootViewController = self.wireframe?.resolve(RootViewControllerType.self) else {
            assertionFailure("expected root view controller type to be registered w/ container")
            return window
        }
        window.rootViewController = rootViewController as? UIViewController
        self.presentedViewController = window.rootViewController
        window.makeKeyAndVisible()
        return window
    }
    
    func routeToLogin() {
        guard let loginRoute = self.wireframe?.route(LoginRouterType.self),
            let presentedViewController = self.presentedViewController else {
            
            assertionFailure("expected login route to be provided")
            return
        }
        
        loginRoute.loadView(fromViewController: presentedViewController)
    }
    
    func routeToHome() {
        guard let homeRoute = self.wireframe?.route(HomeRouterType.self),
            let presentedViewController = self.presentedViewController else {
                
            assertionFailure("expected home route to be provided")
            return
        }
        
        homeRoute.loadView(fromViewController: presentedViewController)
    }
    
    func routeToError() {
        guard let errorRoute = self.wireframe?.route(ErrorRouterType.self),
            let presentedViewController = self.presentedViewController else {
                
            assertionFailure("expected error route to be provided")
            return
        }
        
        errorRoute.loadView(
            fromViewController: presentedViewController,
            withContext: ErrorContext.generic(retryClosure: {
                print("TODO run logic for retrying")
            })
        )
    }
    
    func redetermineInitialView() {
        (self.presentedViewController as? RootViewController)?.redetermineInitialFlow()
    }
}
