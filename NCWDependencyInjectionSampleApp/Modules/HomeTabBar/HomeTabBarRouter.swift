//
//  HomeTabBarRouter.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 07-18-2018.
//

import UIKit

// MARK: Protocols

/// The HomeTabBar router type protocol.
protocol HomeTabBarRouterType: RouteType, HomeTabBarPresenterToRouterType {
    
    func loadView(fromViewController: UIViewController)
}

protocol HomeTabBarPresenterToRouterType {

}

// MARK: Classes

final class HomeTabBarRouter: HomeTabBarRouterType {
    
    weak var wireframe: WireframeType?
    weak var presentedViewController: UIViewController?
    
    deinit {
        print("HomeTabBar router deinit")
    }

    func loadView(fromViewController: UIViewController) {
        guard let presentedViewController = self.wireframe?.resolve(HomeTabBarViewControllerType.self) as? UITabBarController else {
            assertionFailure("expected HomeTabBar view controller type to be registered w/ container")
            return
        }
        
        guard let tabBarItem1VC = self.wireframe?.route(TabBarItem1ViewControllerType.self) as? UIViewController else {
            assertionFailure("expected tab bar item 1 vc to be registered w/ container")
            return
        }
        
        guard let tabBarItem2VC = self.wireframe?.route(TabBarItem2ViewControllerType.self) as? UIViewController else {
            assertionFailure("expected tab bar item 2 vc to be registered w/ container")
            return
        }
        
        guard let tabBarItem3VC = self.wireframe?.route(TabBarItem3ViewControllerType.self) as? UIViewController else {
            assertionFailure("expected tab bar item 3 vc to be registered w/ container")
            return
        }
        
        presentedViewController.viewControllers = [tabBarItem1VC, tabBarItem2VC, tabBarItem3VC]
        
        fromViewController.present(presentedViewController, animated: true, completion: { [weak self] in
            guard let `self` = self else { return }
            self.presentedViewController = presentedViewController
        })
    }
}
