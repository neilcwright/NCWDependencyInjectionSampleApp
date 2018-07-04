//
//  LoginPresenter.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 07-01-2018.
//

protocol LoginRequestType {
    var username: String { get set }
    var password: String { get set }
}
struct LoginRequest: LoginRequestType {
    var username: String
    var password: String
}

// View->Presenter interface.
protocol LoginPresenterType: class {
    
    var interactor: LoginInteractorType { get set }
    var router: LoginPresenterToRouterType? { get set }
    var view: LoginPresenterToViewType? { get set }
    
    /// Will handle the login request action sent from view.
    ///
    /// - Parameter request: the username provided by user input.
    /// - Returns: the password provided by user input.
    func handleLoginRequest(_ request: LoginRequest)
}

// Presenter->View interface for calling view.
protocol LoginPresenterToViewType: class {
    
}

final class LoginPresenter: LoginPresenterType {

    var interactor: LoginInteractorType
    var router: LoginPresenterToRouterType?
    weak var view: LoginPresenterToViewType?
    
    init(interactor: LoginInteractorType) {
        self.interactor = interactor
    }
    
    deinit {
        print("Login presenter deinit")
    }
    
    func handleLoginRequest(_ request: LoginRequest) {
        self.interactor.handleLoginRequest(request)
    }
}

// (Outbound) Interface for receiving the interactor's events.
extension LoginPresenter: LoginInteractorPresenterType {
    func loginSucceeded() {
        self.router?.routeToHomeView()
    }
    
    func loginFailed() {
        
    }
}
