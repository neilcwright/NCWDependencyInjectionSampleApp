//
//  ErrorRouter.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 07-03-2018.
//

import UIKit

// MARK: Typealiases
typealias ErrorRetryClosure = (() -> Void)

// MARK: Models

enum ErrorContext {
    case generic(retryClosure: ErrorRetryClosure?)
    case invalidLoginCredentials(retryClosure: ErrorRetryClosure?)
    case networkUnavailable(retryClosure: ErrorRetryClosure?)
}

// MARK: Protocols

/// The Error router type protocol.
protocol ErrorRouterType: RouteType, ErrorPresenterToRouterType {
    
    /// Will load this route's view from the view controller provided.
    ///
    /// - Parameter fromViewController: the view controller from which we'll present the error view.
    func loadView(fromViewController: UIViewController, withContext: ErrorContext)
}

protocol ErrorPresenterToRouterType {
    
    /// Will retry the last view that errored out.
    func retryLastView()
    
    /// Will dismiss the error view.
    func dismissView()
}

// MARK: Classes

final class ErrorRouter: ErrorRouterType {
    
    weak var wireframe: WireframeType?
    weak var presentedViewController: UIViewController?
    
    fileprivate var context: ErrorContext?
    
    deinit {
        print("Error router deinit")
    }

    func loadView(fromViewController: UIViewController, withContext: ErrorContext = .generic(retryClosure: nil)) {
        self.context = withContext
        guard let presentedViewController = self.wireframe?.resolve(ErrorViewControllerType.self) as? UIViewController else {
            assertionFailure("expected Error view controller type to be registered w/ container")
            return
        }
        
        fromViewController.present(presentedViewController, animated: true, completion: nil)
        self.presentedViewController = presentedViewController
    }
    
    func retryLastView() {
        if let context = self.context {
            switch context {
            case .generic(let retryClosure),
                 .invalidLoginCredentials(let retryClosure),
                 .networkUnavailable(let retryClosure):
                
                self.presentedViewController?.dismiss(animated: true, completion: {
                    retryClosure?()
                })
            }
        }
    }
    
    func dismissView() {
        self.presentedViewController?.dismiss(animated: true, completion: nil)
    }
}
