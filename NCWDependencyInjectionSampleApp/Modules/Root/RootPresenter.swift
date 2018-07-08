//
//  RootPresenter.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 6/16/18.
//  Copyright © 2018 Neil Wright. All rights reserved.
//

import Foundation

// Inbound protocol
protocol RootPresenterType: class {
    
    //  held strongly (owned)
    var interactor: RootInteractorType { get set }
    var router: RootPresenterToRouterType! { get set }
    
    // held weakly
    var view: RootPresenterToViewType? { get set }
    
    /// Will determine the initial view.
    ///
    /// - Returns: the initial view based on the interactor check to be made on app start.
    func determineInitialView()
}

// Presenter -> View interface (held weakly since view owns presenter)
protocol RootPresenterToViewType: class {
    
}

final class RootPresenter: RootPresenterType {
    
    var interactor: RootInteractorType
    var router: RootPresenterToRouterType!
    weak var view: RootPresenterToViewType?
    
    init(interactor: RootInteractorType) {
        self.interactor = interactor
    }
    
    deinit {
        print("root presenter deinit")
    }
    
    func determineInitialView() {
        self.interactor.determineInitialFlow()
    }
}

// MARK: RootInteractorPresenterType
extension RootPresenter: RootInteractorPresenterType {
    func presentLoggedOutFlow() {
        self.router.routeToError()
        //self.router.routeToLogin()
    }
    
    func presentLoggedInFlow() {
        self.router.routeToHome()
    }
}
