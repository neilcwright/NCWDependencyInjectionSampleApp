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
    
    /// Will handle the login request.
    ///
    /// - Parameter loginRequest: the login request structure.
    func handleLoginRequest(_ request: LoginRequest)
}

// outbound protocol interface
protocol LoginInteractorPresenterType: class {
    
    /// Will inform the presenter that login succeeded.
    func loginSucceeded()
    
    /// Will inform the presenter that login failed.
    func loginFailed()
}

final class LoginInteractor: LoginInteractorType {

    var dataManager: LoginDataManagerType
    weak var presenter: LoginInteractorPresenterType?
    
    // MARK: Initializers
    
    init(dataManager: LoginDataManagerType) {
        self.dataManager = dataManager
    }
    
    deinit {
        print("Login interactor deinit")
    }
    
    // MARK: LoginInteractorType
    
    func handleLoginRequest(_ request: LoginRequest) {
        self.dataManager.login(request: request, success: {
            self.presenter?.loginSucceeded()
        }, failure: {
            self.presenter?.loginFailed()
        })
    }
}
