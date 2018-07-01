//
//  HomeRouter.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 6/16/18.
//  Copyright © 2018 Neil Wright. All rights reserved.
//

import UIKit

protocol HomeRouterType: RouteType, HomePresenterToRouterType {
    
    /// Will load this route's view from the view controller specified.
    ///
    /// - Parameter viewController: the vc instance to which we'll load this route's view.
    func loadView(from viewController: UIViewController)
}

protocol HomePresenterToRouterType {
    
    /// Will route to the detail view.
    func routeToDetailView()
    
    /// Will dismiss this view.
    func dismissView()
}

final class HomeRouter: HomeRouterType {
    
    var routeProvider: RouteProviderType?
    weak var presentedViewController: UIViewController?
    
    deinit {
        debugPrint("deinit \(#file) \(#function)")
    }
    
    func loadView(from viewController: UIViewController) {
        guard let homeViewController = self.routeProvider?.resolve(HomeViewControllerType.self) as? UIViewController else {
            
            assertionFailure("expected home view controller to be registered in container")
            return
        }
        
        viewController.present(homeViewController, animated: true, completion: nil)
        self.presentedViewController = homeViewController
    }
    
    func routeToDetailView() {
        guard let detailRoute = self.routeProvider?.route(DetailRouterType.self),
            let presentedViewController = self.presentedViewController else {
                
                assertionFailure("expected home route to be registered w/ container")
                return
        }
        
        detailRoute.loadView(from: presentedViewController)
    }
    
    func dismissView() {
        self.presentedViewController?.dismiss(animated: true, completion: nil)
    }
}
