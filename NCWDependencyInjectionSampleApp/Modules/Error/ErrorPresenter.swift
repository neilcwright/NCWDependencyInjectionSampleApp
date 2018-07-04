//
//  ErrorPresenter.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 07-03-2018.
//

// View->Presenter interface.
protocol ErrorPresenterType: class {
    
    var interactor: ErrorInteractorType { get set }
    var router: ErrorPresenterToRouterType? { get set }
    var view: ErrorPresenterToViewType? { get set }
}

// Presenter->View interface for calling view.
protocol ErrorPresenterToViewType: class {
    
}

final class ErrorPresenter: ErrorPresenterType {
    
    var interactor: ErrorInteractorType
    var router: ErrorPresenterToRouterType?
    weak var view: ErrorPresenterToViewType?
    
    init(interactor: ErrorInteractorType) {
        self.interactor = interactor
    }
    
    deinit {
        print("Error presenter deinit")
    }
}

// (Outbound) Interface for receiving the interactor's events.
extension ErrorPresenter: ErrorInteractorPresenterType {
    
}
