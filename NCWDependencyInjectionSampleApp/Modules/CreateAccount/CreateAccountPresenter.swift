//
//  CreateAccountPresenter.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 07-08-2018.
//

// View->Presenter interface.
protocol CreateAccountPresenterType: class {
    
    var interactor: CreateAccountInteractorType { get set }
    var router: CreateAccountPresenterToRouterType? { get set }
    var view: CreateAccountPresenterToViewType? { get set }
    
    /// Will request to create a new account.
    ///
    /// - Parameters:
    ///   - username: the username to use in new account.
    ///   - email: the email to use in new account.
    ///   - password: the password to use in new account.
    /// - Returns: Void
    func requestNewAccount(username: String, email: String, password: String)
}

// Presenter->View interface for calling view.
protocol CreateAccountPresenterToViewType: class {
    
}

final class CreateAccountPresenter: CreateAccountPresenterType {
    
    var interactor: CreateAccountInteractorType
    var router: CreateAccountPresenterToRouterType?
    weak var view: CreateAccountPresenterToViewType?
    
    init(interactor: CreateAccountInteractorType) {
        self.interactor = interactor
    }
    
    deinit {
        print("CreateAccount presenter deinit")
    }
    
    func requestNewAccount(username: String, email: String, password: String) {
        self.interactor.createNewAccount(
            with: AccountRequest(
                username: username,
                email: email,
                password: password
            )
        )
    }
}

// (Outbound) Interface for receiving the interactor's events.
extension CreateAccountPresenter: CreateAccountInteractorPresenterType {
    func accountCreatedSuccess() {
        
    }
    
    func accountCreatedFailure() {
        self.router?.routeToError()
    }
}
