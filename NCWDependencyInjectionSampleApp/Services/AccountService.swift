//
//  AccountService.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 7/1/18.
//  Copyright © 2018 Neil Wright. All rights reserved.
//

import Foundation

// MARK: Models

fileprivate enum ServiceEndpoint {
    case login
    case createAccount
    
    var path: String {
        switch self {
        case .login:
            return "login"
        case .createAccount:
            return "create_account"
        }
    }
}

struct LoginCredentials: LoginRequestType {
    var username: String
    var email: String
    var password: String
}

struct AccountRequest {
    let username: String
    let email: String
    let password: String
}

protocol AccountServiceType: class {
    
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
    
    /// Will make a request to create a new account in system.
    ///
    /// - Parameters:
    ///   - accountRequest: the request content for new account.
    ///   - success: handler to be called on success.
    ///   - failure: handler to be called on failure.
    func createAccount(
        with accountRequest: AccountRequest,
        success: @escaping (() -> Void),
        failure: @escaping (() -> Void)
    )
}

final class AccountService: AccountServiceType {
    
    private let baseUrl: String
    
    init(baseUrl: String) {
        self.baseUrl = baseUrl
        debugPrint("base url: \(baseUrl)")
    }
    
    func login(
        with credentials: LoginCredentials,
        success: @escaping (() -> Void),
        failure: @escaping (() -> Void)) {
        
        guard let baseUrl = URL(string: self.baseUrl) else {
            DispatchQueue.main.async {
                failure()
            }
            return
        }
        guard let url = URL(string: ServiceEndpoint.login.path, relativeTo: baseUrl) else {
            DispatchQueue.main.async {
                failure()
            }
            return
        }
        
        guard !credentials.username.isEmpty && !credentials.password.isEmpty else {
            DispatchQueue.main.async {
                // TODO throw a more specific error
                failure()
            }
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = "username=\(credentials.username)&email=\(credentials.email)&password=\(credentials.password)".data(using: .utf8)
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    failure()
                }
                return
            }
            
            guard let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == 200 else {
                DispatchQueue.main.async {
                   failure()
                }
                return
            }
            
            let responseString = String(data: data, encoding: .utf8)
            debugPrint("response string: \(String(describing: responseString))")
            debugPrint("httpStatus: \(httpStatus)")
            
            DispatchQueue.main.async {
                success()
            }
        }
        dataTask.resume()
    }
    
    func createAccount(
        with accountRequest: AccountRequest,
        success: @escaping (() -> Void),
        failure: @escaping (() -> Void)) {
        
        guard let baseUrl = URL(string: self.baseUrl) else {
            assertionFailure("expect base url to be set")
            DispatchQueue.main.async {
                failure()
            }
            return
        }
        
        guard let createAccountUrl = URL(
            string: ServiceEndpoint.createAccount.path,
            relativeTo: baseUrl
        ) else {
            assertionFailure("expect create account url to be set")
            DispatchQueue.main.async {
                failure()
            }
            return
        }

        var request = URLRequest(url: createAccountUrl)
        request.httpMethod = "POST"
        request.httpBody = "username=\(accountRequest.username)&email=\(accountRequest.email)&password=\(accountRequest.password)".data(using: .utf8)
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    failure()
                }
                return
            }
            
            guard let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode == 200 else {
                DispatchQueue.main.async {
                    failure()
                }
                return
            }
            
            let responseString = String(data: data, encoding: .utf8)
            debugPrint("response string: \(String(describing: responseString))")
            debugPrint("httpStatus: \(httpStatus)")
            
            DispatchQueue.main.async {
                success()
            }
        }
        dataTask.resume()
    }
}
