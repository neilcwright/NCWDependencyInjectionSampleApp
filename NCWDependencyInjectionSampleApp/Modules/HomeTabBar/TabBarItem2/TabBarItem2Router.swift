//
//  TabBarItem2Router.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 07-18-2018.
//

import UIKit

// MARK: Protocols

/// The TabBarItem2 router type protocol.
protocol TabBarItem2RouterType: RouteType, TabBarItem2PresenterToRouterType {
    
    func loadView(fromViewController: UIViewController)
}

protocol TabBarItem2PresenterToRouterType {

}

// MARK: Classes

final class TabBarItem2Router: TabBarItem2RouterType {
    
    weak var wireframe: WireframeType?
    weak var presentedViewController: UIViewController?
    
    deinit {
        print("TabBarItem2 router deinit")
    }

    func loadView(fromViewController: UIViewController) {
        guard let presentedViewController = self.wireframe?.resolve(TabBarItem2ViewControllerType.self) as? UIViewController else {
            assertionFailure("expected TabBarItem2 view controller type to be registered w/ container")
            return
        }
        
        fromViewController.present(presentedViewController, animated: true, completion: nil)
        self.presentedViewController = presentedViewController
    }
}
