//
//  ErrorRouter.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 07-03-2018.
//

import UIKit

// MARK: Protocols

/// The Error router type protocol.
protocol ErrorRouterType: RouteType, ErrorPresenterToRouterType {
    
    func loadView(fromViewController: UIViewController)
}

protocol ErrorPresenterToRouterType {

}

// MARK: Classes

final class ErrorRouter: ErrorRouterType {
    
    weak var routeProvider: RouteProviderType?
    weak var presentedViewController: UIViewController?
    
    deinit {
        print("Error router deinit")
    }

    func loadView(fromViewController: UIViewController) {
        guard let presentedViewController = self.routeProvider?.resolve(ErrorViewControllerType.self) as? UIViewController else {
            assertionFailure("expected Error view controller type to be registered w/ container")
            return
        }
        
        fromViewController.present(presentedViewController, animated: true, completion: nil)
        self.presentedViewController = presentedViewController
    }
}
