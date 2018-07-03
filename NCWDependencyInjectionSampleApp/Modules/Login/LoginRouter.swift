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

protocol LoginPresenterToRouterType {

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
}
