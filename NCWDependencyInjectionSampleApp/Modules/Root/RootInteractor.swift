//
//  RootInteractor.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 6/16/18.
//  Copyright © 2018 Neil Wright. All rights reserved.
//

import Foundation

// inbound protocol interface
protocol RootInteractorType: class {
    // held strongly
    var dataManager: RootDataManagerType! { get set }
    
    // held weakly (is owned by)
    var presenter: RootInteractorPresenterType! { get set }
    
    func determineInitialFlow()
}

// outbound protocol interface
protocol RootInteractorPresenterType: class {
    func presentLoggedInFlow()
    
    func presentLoggedOutFlow()
}

final class RootInteractor: RootInteractorType {
    var dataManager: RootDataManagerType!
    var presenter: RootInteractorPresenterType!
    
    func determineInitialFlow() {
        if self.dataManager.isUserLoggedIn() {
            self.presenter.presentLoggedInFlow()
        } else {
            self.presenter.presentLoggedOutFlow()
        }
    }
}
