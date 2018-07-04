//
//  ErrorInteractor.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 07-03-2018.
//

// inbound protocol interface
protocol ErrorInteractorType: class {
    // held strongly
    var dataManager: ErrorDataManagerType { get set }
    
    // held weakly (is owned by)
    var presenter: ErrorInteractorPresenterType? { get set }
}

// outbound protocol interface
protocol ErrorInteractorPresenterType: class {

}

final class ErrorInteractor: ErrorInteractorType {
    
    var dataManager: ErrorDataManagerType
    weak var presenter: ErrorInteractorPresenterType?
    
    init(dataManager: ErrorDataManagerType) {
        self.dataManager = dataManager
    }
    
    deinit {
        print("Error interactor deinit")
    }
}
