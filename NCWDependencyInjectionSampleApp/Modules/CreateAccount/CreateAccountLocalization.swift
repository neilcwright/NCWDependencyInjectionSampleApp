//
//  CreateAccountLocalization.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 07-08-2018.
//

import Foundation

fileprivate let tableName = "CreateAccount"
struct CreateAccountLocalization {

    static var headerText: String {
        return "create.account.view.header.text".localized(tableName: tableName)
    }
    
    static var emailLabelText: String {
        return "create.account.view.email.label.text".localized(tableName: tableName)
    }
    
    static var emailFieldPlaceholderText: String {
        return "create.account.view.email.field.placeholder.text".localized(tableName: tableName)
    }
    
    static var passwordLabelText: String {
        return "create.account.view.password.label.text".localized(tableName: tableName)
    }
    
    static var passwordFieldPlaceholderText: String {
        return "create.account.view.password.field.placeholder.text".localized(tableName: tableName)
    }
    
    static var submitButtonText: String {
        return "create.account.view.submit.button.text".localized(tableName: tableName)
    }
}
