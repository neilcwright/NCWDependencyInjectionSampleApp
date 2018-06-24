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
protocol RootRouterType: RouteType {
    
    /// Will load this route's view in the provided window and return it after
    /// assigning the view to it.
    ///
    /// - Parameter window: the window that we'll load view into.
    /// - Returns: the loaded window.
    func loadView(in window: UIWindow) -> UIWindow
    
    /// Will route to home.
    func routeToHome()
    
    // Will route to login.
    func routeToLogin()
}

// MARK: Classes

final class RootRouter: RootRouterType {
    
    weak var routeProvider: RouteProviderType?
    var window: UIWindow?
    var presentedViewController: UIViewController?
    
    deinit {
        print("root router deinit")
    }
    
    @discardableResult
    func loadView(in window: UIWindow) -> UIWindow {
        guard let rootViewController = self.routeProvider?.resolve(RootViewControllerType.self) else {
            assertionFailure("expected root view controller type to be registered w/ container")
            return window
        }
        window.rootViewController = rootViewController as? UIViewController
        self.presentedViewController = window.rootViewController
        return window
    }
    
    func routeToLogin() {
        // TODO route to login
    }
    
    func routeToHome() {
        guard let homeRoute = self.routeProvider?.route(HomeRouterType.self),
            let presentedViewController = self.presentedViewController else {
                
                assertionFailure("expected home route to be registered w/ container")
                return
        }
        
        homeRoute.loadView(from: presentedViewController)
    }
}
