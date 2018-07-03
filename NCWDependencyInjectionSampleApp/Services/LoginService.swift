//
//  LoginService.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 7/1/18.
//  Copyright © 2018 Neil Wright. All rights reserved.
//

import Foundation

// MARK: Models

fileprivate enum ServiceEndpoint {
    case helloWorld
    case login
    
    var path: String {
        switch self {
        case .helloWorld:
            return "hello"
        case .login:
            return "login"
        }
    }
}

struct LoginCredentials {
    var userName: String
    var password: String
}

protocol LoginServiceType: class {
    
    /// Will login user if credentials are valid; otherwise will return a failure.
    ///
    /// - Parameters:
    ///   - credentials: the credentials to use for login request.
    ///   - success: handler to be called on success.
    ///   - failure: handler to be called on failure.
    func login(
        with credentials: LoginCredentials,
        success: @escaping (() -> Void),
        failure: @escaping (() -> Void))
}

final class LoginService: LoginServiceType {
    
    fileprivate let baseUrl: String
    
    init(baseUrl: String) {
        self.baseUrl = baseUrl
    }
    
    func login(
        with credentials: LoginCredentials,
        success: @escaping (() -> Void),
        failure: @escaping (() -> Void)) {
        
        
    }
}
