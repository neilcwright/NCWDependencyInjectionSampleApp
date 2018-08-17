//
//  TabBarItem1Router.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 07-18-2018.
//

import UIKit

// MARK: Protocols

/// The TabBarItem1 router type protocol.
protocol TabBarItem1RouterType: RouteType, TabBarItem1PresenterToRouterType {
    
    func loadView(fromViewController: UIViewController)
}

protocol TabBarItem1PresenterToRouterType {

}

// MARK: Classes

final class TabBarItem1Router: TabBarItem1RouterType {
    
    weak var wireframe: WireframeType?
    weak var presentedViewController: UIViewController?
    
    deinit {
        print("TabBarItem1 router deinit")
    }

    func loadView(fromViewController: UIViewController) {
        guard let presentedViewController = self.wireframe?.resolve(TabBarItem1ViewControllerType.self) as? UIViewController else {
            assertionFailure("expected TabBarItem1 view controller type to be registered w/ container")
            return
        }
        
        fromViewController.present(presentedViewController, animated: true, completion: nil)
        self.presentedViewController = presentedViewController
    }
}
