//
//  LoginDataManager.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 07-01-2018.
//


protocol LoginDataManagerType: class {
    
    /// Will attempt to login user.
    ///
    /// - Parameters:
    ///   - request: login request credentials
    ///   - success: the success handler
    ///   - failure: the failure handler
    func login(
        request: LoginRequest,
        success: @escaping (() -> Void),
        failure: @escaping (() -> Void)
    )
    
    /// Will attempt to create a new account given the provided credentials.
    ///
    /// - Parameters:
    ///   - success: success handler to call
    ///   - failure: failure handler to call
    func createAccount(success: @escaping (() -> Void), failure: @escaping (() -> Void))
}

final class LoginDataManager: LoginDataManagerType {
    
    private let accountService: AccountServiceType
    
    init(accountService: AccountServiceType) {
        self.accountService = accountService
    }
    
    func login(
        request: LoginRequest,
        success: @escaping (() -> Void),
        failure: @escaping (() -> Void)) {
        
        self.accountService.login(
            with: LoginCredentials(
                username: request.username,
                email: request.email,
                password: request.password
        ), success: {
            success()
        }, failure: {
            failure()
        })
    }
    
    func createAccount(success: @escaping (() -> Void), failure: @escaping (() -> Void)) {
        print("TODO create account")
    }
}
