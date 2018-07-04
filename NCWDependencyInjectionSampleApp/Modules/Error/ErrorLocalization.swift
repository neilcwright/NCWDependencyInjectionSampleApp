//
//  ErrorLocalization.swift
//  NCWDependencyInjectionSampleApp
//
//  Created by Neil Wright on 07-03-2018.
//

import Foundation

fileprivate let tableName = "Error"

protocol ErrorLocalizable {
    static var headerText: String { get }
}

struct ErrorLocalization {

    struct Generic: ErrorLocalizable {
        static var headerText: String {
            return "error.view.general.header.text".localized(tableName: tableName)
        }
    }
    
    struct InvalidLoginCredentials: ErrorLocalizable {
        static var headerText: String {
            return "error.view.invalid.login.credentials.header.text".localized(tableName: tableName)
        }
    }
}
