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
    var router: RootRouterPresenterType? { get set }
    
    func determineInitialView()
}

// Outbound protocol
protocol RootPresenterDelegateType: class {
    
}

final class RootPresenter: RootPresenterType {
    
    var interactor: RootInteractorType!
    weak var router: RootRouterPresenterType?
    
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
        self.router?.routeToHome()
    }
}
