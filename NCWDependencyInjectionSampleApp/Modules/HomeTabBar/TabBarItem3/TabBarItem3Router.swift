//
//  TabBarItem3Router.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 07-18-2018.
//

import UIKit

// MARK: Protocols

/// The TabBarItem3 router type protocol.
protocol TabBarItem3RouterType: RouteType, TabBarItem3PresenterToRouterType {
    
    func loadView(fromViewController: UIViewController)
}

protocol TabBarItem3PresenterToRouterType {
    func dismissBackToRootRoute()
}

// MARK: Classes

final class TabBarItem3Router: TabBarItem3RouterType {

    weak var wireframe: WireframeType?
    weak var presentedViewController: UIViewController?
    
    deinit {
        print("TabBarItem3 router deinit")
    }

    func loadView(fromViewController: UIViewController) {
        guard let presentedViewController = self.wireframe?.resolve(TabBarItem3ViewControllerType.self) as? UIViewController else {
            assertionFailure("expected TabBarItem3 view controller type to be registered w/ container")
            return
        }
        
        fromViewController.present(presentedViewController, animated: true, completion: {
            [weak self] in
            guard let `self` = self else { return }
            self.presentedViewController = presentedViewController
        })
    }
    
    func dismissBackToRootRoute() {
        self.wireframe?.route(RootRouterType.self)?
            .presentedViewController?.dismiss(animated: true, completion: nil)
    }
}
