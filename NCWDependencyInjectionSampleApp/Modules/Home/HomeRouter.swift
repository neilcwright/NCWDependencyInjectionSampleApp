//
//  HomeRouter.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 6/16/18.
//  Copyright © 2018 Neil Wright. All rights reserved.
//

import UIKit

protocol HomeRouterType: RouteType {
    
    func loadView(from viewController: UIViewController)
    
    func routeToDetailView()
} 

final class HomeRouter: HomeRouterType {
    
    var routeProvider: RouteProviderType?
    var presentedViewController: UIViewController?
    
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
