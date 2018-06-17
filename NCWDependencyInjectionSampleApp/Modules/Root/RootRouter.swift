//
//  RootRouter.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 6/16/18.
//  Copyright © 2018 Neil Wright. All rights reserved.
//

import UIKit

// MARK: Protocols

protocol RouteType: class {

}

protocol RootRouterType: RouteType {
    
    var rootViewController: UIViewController! { get set }

    // retain strong
    var presenter: RootPresenterType { get set }
    
    func setRootViewController(_ rootViewController: UIViewController & ContainerViewControllerType)
    
    func routeToView()
}

protocol RootRouterPresenterType: class {
    func routeToHome()
    
    func routeToLogin()
}

// MARK: Classes

final class RootRouter: RootRouterType {

    var rootViewController: UIViewController!
    
    var presenter: RootPresenterType
    
    required init(
        presenter: RootPresenterType) {
        
        self.presenter = presenter
    }
    
    deinit {
        print("root router deinit")
    }
    
    func setRootViewController(_ rootViewController: UIViewController & ContainerViewControllerType) {
        self.rootViewController = rootViewController
    }

    func routeToView() {
        self.presenter.determineInitialView()
    }
}

extension RootRouter: RootRouterPresenterType {
    func routeToLogin() {
        
    }
    
    func routeToHome() {
        
    }
}
