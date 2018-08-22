//
//  ServiceEndpoint.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 8/21/18.
//  Copyright © 2018 Neil Wright. All rights reserved.
//

enum ServiceEndpoint {
    case login
    case createAccount
    
    var relativePath: String {
        switch self {
        case .login:
            return "login"
        case .createAccount:
            return "create_account"
        }
    }
}
