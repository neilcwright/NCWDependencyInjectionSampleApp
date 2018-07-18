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

final class HomeRouter: NSObject, HomeRouterType {
    
    var appRouter: AppRouterType?
    weak var presentedViewController: UIViewController?
    
    deinit {
        debugPrint("deinit \(#file) \(#function)")
    }
    
    func loadView(from viewController: UIViewController) {
        guard let homeViewController = self.appRouter?.resolve(HomeViewControllerType.self) as? UIViewController else {
            
            assertionFailure("expected home view controller to be registered in container")
            return
        }
        
        homeViewController.transitioningDelegate = self
        homeViewController.modalPresentationStyle = .custom
        viewController.present(homeViewController, animated: true, completion: nil)
        self.presentedViewController = homeViewController
    }
    
    func routeToDetailView() {
        guard let detailRoute = self.appRouter?.route(DetailRouterType.self),
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

// MARK: UIViewControllerTransitioningDelegate
extension HomeRouter: UIViewControllerTransitioningDelegate {
    
    func animationController(
        forPresented presented: UIViewController,
        presenting: UIViewController,
        source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        
        return ScaleFromCenterPresentingAnimator()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return ScaleFromCenterDismissingAnimator()
    }
}
