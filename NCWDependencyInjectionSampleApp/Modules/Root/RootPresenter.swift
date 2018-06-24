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
    
    var interactor: RootInteractorType! { get set }
    var router: RootRouterType? { get set }
    
    func determineInitialView()
}

// Outbound protocol
protocol RootPresenterDelegateType: class {
    
}

class RootPresenter: RootPresenterType {
    
    var interactor: RootInteractorType!
    weak var router: RootRouterType?
    
    deinit {
        print("root presenter deinit")
    }
    
    func determineInitialView() {
        self.interactor.determineInitialFlow()
    }
}

extension RootPresenter: RootInteractorPresenterType {
    func presentLoggedOutFlow() {
        self.router?.routeToLogin()
    }
    
    func presentLoggedInFlow() {
        assert(self.router != nil)
        self.router?.routeToHome()
    }
}
