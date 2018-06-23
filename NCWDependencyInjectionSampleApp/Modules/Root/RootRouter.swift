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
protocol RootRouterType: RouteType, RootRouterPresenterType {
    func loadView()
}

protocol RootRouterPresenterType: class {
    
    /// Will route to home.
    func routeToHome()
    
    // Will route to login.
    func routeToLogin()
}

// MARK: Classes

final class RootRouter: RootRouterType {
    
    weak var routeProvider: RouteProviderType?
    var window: UIWindow?
    
    deinit {
        print("root router deinit")
    }
    
    func loadView() {
        let rootViewController = UITableViewController()
        self.window = UIWindow(frame: UIScreen.main.bounds)
        self.window?.rootViewController = rootViewController
        self.window?.makeKeyAndVisible()
    }
}

extension RootRouter: RootRouterPresenterType {
    func routeToLogin() {
        // TODO route to login
    }
    
    func routeToHome() {
        // TODO route to home
    }
}
