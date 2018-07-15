//
//  CreateAccountDataManager.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 07-08-2018.
//


protocol CreateAccountDataManagerType: class {
    
    /// Will make the request to create account using account service.
    ///
    /// - Parameters:
    ///   - request: the request object for creating account.
    ///   - success: handler to be called on success.
    ///   - failure: handler to be called on failure.
    func createAccount(
        with request: AccountRequest,
        success: @escaping (() -> Void),
        failure: @escaping(() -> Void))
}

final class CreateAccountDataManager: CreateAccountDataManagerType {
    let accountService: AccountServiceType
    
    init(accountService: AccountServiceType) {
        self.accountService = accountService
    }
    
    func createAccount(
        with request: AccountRequest,
        success: @escaping (() -> Void),
        failure: @escaping (() -> Void)) {
        
        self.accountService.createAccount(with: request, success: success, failure: failure)
    }
}
