//
//  CreateAccountInteractor.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 07-08-2018.
//

// inbound protocol interface
protocol CreateAccountInteractorType: class {
    
    // held strongly
    var dataManager: CreateAccountDataManagerType { get set }
    
    // held weakly (is owned by)
    var presenter: CreateAccountInteractorPresenterType? { get set }
    
    /// Informs interactor to make the request to create new account.
    ///
    /// - Parameter request: the account request object.
    func createNewAccount(with request: AccountRequest)
}

// outbound protocol interface
protocol CreateAccountInteractorPresenterType: class {
    
    /// Will be called on the event that account was created successfully.
    func accountCreatedSuccess()
    
    /// Will be called on the event that account failed to be created.
    func accountCreatedFailure()
}

final class CreateAccountInteractor: CreateAccountInteractorType {
    
    var dataManager: CreateAccountDataManagerType
    weak var presenter: CreateAccountInteractorPresenterType?
    
    init(dataManager: CreateAccountDataManagerType) {
        self.dataManager = dataManager
    }
    
    deinit {
        print("CreateAccount interactor deinit")
    }
    
    func createNewAccount(with request: AccountRequest) {
        self.dataManager.createAccount(
            with: request,
            success: {
                [weak self] in
                self?.presenter?.accountCreatedSuccess()
            },
            failure: {
                [weak self] in
                self?.presenter?.accountCreatedFailure()
            }
        )
    }
}
