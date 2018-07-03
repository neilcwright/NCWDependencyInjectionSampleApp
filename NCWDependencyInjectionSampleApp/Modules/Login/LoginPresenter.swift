//
//  LoginPresenter.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 07-01-2018.
//

// View->Presenter interface.
protocol LoginPresenterType: class {
    
    var interactor: LoginInteractorType { get set }
    var router: LoginPresenterToRouterType? { get set }
    var view: LoginPresenterToViewType? { get set }
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
}

// (Outbound) Interface for receiving the interactor's events.
extension LoginPresenter: LoginInteractorPresenterType {
    
}
