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

struct LoginCredentials: LoginRequestType {
    var username: String
    var password: String
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
}

final class AccountService: AccountServiceType {
    
    fileprivate let baseUrl: String
    
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
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.httpBody = "name=\(credentials.username)&password=\(credentials.password)".data(using: .utf8)
        
        let dataTask = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data, error == nil else {
                DispatchQueue.main.async {
                    failure()
                }
                return
            }
            
            guard let httpStatus = response as? HTTPURLResponse, httpStatus.statusCode != 200 else {
                DispatchQueue.main.async {
                   failure()
                }
                return
            }
            
            let responseString = String(data: data, encoding: .utf8)
            debugPrint("response string: \(String(describing: responseString))")
            
            DispatchQueue.main.async {
                success()
            }
        }
        dataTask.resume()
    }
}
