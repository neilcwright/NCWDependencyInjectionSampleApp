//
//  LoginLocalization.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 07-01-2018.
//

import Foundation

fileprivate let tableName = "Login"

struct LoginLocalization {
    
    static var usernameLabel: String {
        return "login.view.username.label.text".localized(tableName: tableName)
    }
    
    static var emailLabel: String {
        return "login.view.email.label.text".localized(tableName: tableName)
    }
    
    static var passwordLabel: String {
        return "login.view.password.label.text".localized(tableName: tableName)
    }
    static var submitButton: String {
        return "login.view.submit.button.text".localized(tableName: tableName)
    }
    static var createAccountButtonText: String {
        return "login.view.create.account.button.text".localized(tableName: tableName)
    }
}
