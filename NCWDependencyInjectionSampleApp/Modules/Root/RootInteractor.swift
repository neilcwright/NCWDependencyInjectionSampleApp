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
    var dataManager: RootDataManagerType { get set }
    
    // auto-wired property held weakly
    var presenter: RootInteractorPresenterType? { get set }
    
    /// Will determine the initial flow upon app start.
    func determineInitialFlow()
}

// outbound protocol interface
protocol RootInteractorPresenterType: class {
    
    /// Will present the logged in flow.
    func presentLoggedInFlow()
    
    /// Will present the logged out flow.
    func presentLoggedOutFlow()
}


final class RootInteractor: RootInteractorType {
    
    // MARK: RootInteractorType
    
    var dataManager: RootDataManagerType
    weak var presenter: RootInteractorPresenterType?
    
    // MARK: Initializers
    
    init(dataManager: RootDataManagerType) {
        self.dataManager = dataManager
    }
    
    deinit {
        print("root interactor deinit")
    }
    
    func determineInitialFlow() {
        if self.dataManager.isUserLoggedIn() {
            self.presenter?.presentLoggedInFlow()
        } else {
            self.presenter?.presentLoggedOutFlow()
        }
    }
}
