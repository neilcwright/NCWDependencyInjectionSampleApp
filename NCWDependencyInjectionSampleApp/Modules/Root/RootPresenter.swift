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
    var router: RootPresenterToRouterType? { get set }
    
    func determineInitialView()
}

class RootPresenter: RootPresenterType {
    
    var interactor: RootInteractorType!
    var router: RootPresenterToRouterType?
    
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
