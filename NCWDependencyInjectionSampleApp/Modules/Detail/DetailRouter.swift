//
//  DetailRouter.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 6/16/18.
//  Copyright © 2018 Neil Wright. All rights reserved.
//

import UIKit

// MARK: Protocols

protocol DetailRouterType: RouteType {
    
    // retain strong
    var presenter: DetailPresenterType! { get set }
    
    /// Will load this route's view from the specified view controller.
    ///
    /// - Parameter viewController: the vc to present this routes view from.
    func loadView(from viewController: UIViewController)
}

// MARK: Classes

final class DetailRouter: DetailRouterType {
    
    var routeProvider: RouteProviderType?
    var presenter: DetailPresenterType!
    var presentedViewController: UIViewController?
    
    func routeToHome() {
        print("detail: routeToHome")
    }
    
    func loadView(from viewController: UIViewController) {
        guard let detailViewController = self.routeProvider?.resolve(DetailViewControllerType.self) as? UIViewController else {
            assertionFailure("expected detail view controller to be provided")
            return
        }
        
        viewController.present(detailViewController, animated: true, completion: {
            [weak self, weak detailViewController] in
            self?.presentedViewController = detailViewController
        })
    }
}
