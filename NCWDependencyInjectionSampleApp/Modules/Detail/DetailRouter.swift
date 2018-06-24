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
    
    /// Will route to the alert view.
    func routeToAlert()
}

// MARK: Classes

final class DetailRouter: DetailRouterType {
    
    var routeProvider: RouteProviderType?
    var presenter: DetailPresenterType!
    weak var presentedViewController: UIViewController?

    deinit {
        debugPrint("deinit: \(#file) \(#function)")
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
    
    func routeToAlert() {
        let alertController = UIAlertController(title: "Detail", message: "How cool is this!", preferredStyle: .alert)
        alertController.addAction(
            UIAlertAction(
                title: "Ok",
                style: .default,
                handler: {
                    [weak self, weak alertController] action in

                    alertController?.dismiss(animated: true, completion: nil)
                    self?.presentedViewController?.dismiss(animated: true, completion: nil)
                }
            )
        )
        self.presentedViewController?.present(alertController, animated: true, completion: nil)
    }
}
