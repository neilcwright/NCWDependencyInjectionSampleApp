//
//  LoginInteractor.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 07-01-2018.
//

// inbound protocol interface
protocol LoginInteractorType: class {
    // held strongly
    var dataManager: LoginDataManagerType { get set }
    
    // held weakly (is owned by)
    var presenter: LoginInteractorPresenterType? { get set }
}

// outbound protocol interface
protocol LoginInteractorPresenterType: class {

}

final class LoginInteractor: LoginInteractorType {
    
    var dataManager: LoginDataManagerType
    weak var presenter: LoginInteractorPresenterType?
    
    init(dataManager: LoginDataManagerType) {
        self.dataManager = dataManager
    }
    
    deinit {
        print("Login interactor deinit")
    }
}
